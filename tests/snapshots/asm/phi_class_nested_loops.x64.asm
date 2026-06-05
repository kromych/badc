
phi_class_nested_loops.x64:	file format elf64-x86-64

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
               	movq	%rdi, %rax
               	movslq	%eax, %rax
               	xorq	%rdx, %rdx
               	movl	%edx, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rcx
               	cmpq	%rax, %rcx
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rcx
               	movslq	(%rcx), %rsi
               	addq	$0x1, %rsi
               	movl	%esi, (%rcx)
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	movl	%esi, -0x10(%rbp)
               	jmp	<addr>
               	movslq	%edx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x10(%rbp), %rcx
               	cmpq	%rax, %rcx
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movslq	(%rcx), %rdi
               	addq	$0x1, %rdi
               	movl	%edi, (%rcx)
               	jmp	<addr>
               	movslq	%esi, %rcx
               	addq	$0x1, %rcx
               	movslq	%ecx, %rsi
               	jmp	<addr>
               	movslq	%edx, %rcx
               	movslq	%esi, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rdx
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x7, %edi
               	popq	%rbp
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
