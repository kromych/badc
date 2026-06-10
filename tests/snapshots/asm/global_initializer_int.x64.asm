
global_initializer_int.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x230, %esi            # imm = 0x230
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpq	$0x2a, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x63, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movslq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq
               	addb	%al, (%rax)
