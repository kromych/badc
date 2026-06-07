
phi_class_for_loop_sum.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %rdi
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movslq	%eax, %rdx
               	cmpq	%rdi, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%eax, %rax
               	incq	%rax
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	movslq	%eax, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0xa, %edi
               	popq	%rbp
               	jmp	<addr>
               	addb	%al, (%rax)
