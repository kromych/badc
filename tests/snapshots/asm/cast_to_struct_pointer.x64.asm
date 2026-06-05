
cast_to_struct_pointer.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x10, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x2a, %ecx
               	movl	%ecx, (%rax)
               	movq	%rax, %rcx
               	addq	$0x8, %rcx
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rcx)
               	movslq	(%rax), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
