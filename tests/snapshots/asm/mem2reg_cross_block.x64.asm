
mem2reg_cross_block.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0xe, %eax
               	xorq	%rdx, %rdx
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movslq	%edx, %rsi
               	cmpq	$0x3, %rsi
               	jge	<addr>
               	movslq	%ecx, %rcx
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movslq	%edx, %rdx
               	incq	%rdx
               	movslq	%edx, %rdx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
