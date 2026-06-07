
unsigned_div_in_assign.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movq	(%rdi), %rax
               	movl	$0x18, %ecx
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rcx
               	popq	%rdx
               	movq	(%rdi), %rcx
               	movl	$0x7, %edx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movslq	%eax, %rax
               	imulq	$0x64, %rax, %rax
               	movslq	%eax, %rdx
               	movslq	%ecx, %rax
               	addq	%rax, %rdx
               	movslq	%edx, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	popq	%r11
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	cmpq	$0x3ea, %rax            # imm = 0x3EA
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	jmp	<addr>
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
