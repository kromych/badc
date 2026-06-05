
mem2reg_addr_taken_neighbor.x64:	file format elf64-x86-64

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
               	xorq	%rsi, %rsi
               	movl	%esi, -0x8(%rbp)
               	shlq	$0x1, %rax
               	movslq	%eax, %rax
               	leaq	-0x8(%rbp), %rcx
               	jmp	<addr>
               	movslq	%esi, %rdx
               	cmpq	$0x3, %rdx
               	jge	<addr>
               	movslq	(%rcx), %rdx
               	movslq	%eax, %rdi
               	addq	%rdi, %rdx
               	movslq	%edx, %rdx
               	movl	%edx, (%rcx)
               	movslq	%esi, %rdx
               	addq	$0x1, %rdx
               	movslq	%edx, %rsi
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x7, %edi
               	popq	%rbp
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
