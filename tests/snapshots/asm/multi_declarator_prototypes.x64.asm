
multi_declarator_prototypes.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2
               	movq	%rdi, %rax
               	movslq	%eax, %rax
               	retq
               	movslq	%edi, %rdi
               	movq	%rdi, %rax
               	shlq	$0x1, %rax
               	movslq	%eax, %rax
               	retq
               	leaq	<rip>, %rax
               	movl	$0xa, %ecx
               	movl	%ecx, (%rax)
               	movl	$0x3, %ecx
               	cmpq	$0x3, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x3, %ecx
               	shlq	$0x1, %rcx
               	movslq	%ecx, %rcx
               	cmpq	$0x6, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movslq	(%rax), %rax
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorq	%rax, %rax
               	retq
