
binop_imm_chain_fold.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rbx
               	leaq	<rip>, %r9
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	leaq	<rip>, %r8
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	addq	%r9, %r8
               	movq	(%r8), %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%rdi, %rdi
               	leaq	<rip>, %r8
               	movq	%r8, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	<rip>, %r8
               	movq	%r8, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	<rip>, %r8
               	movq	%r8, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %rsi
               	movq	(%rsi), %r8
               	movq	%r8, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdi
               	movq	(%rax), %rax
               	movq	%rax, (%rdi)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	shlq	$0x3, %rbx
               	addq	%rbx, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0xa, %r11d
               	movq	%r11, %r9
               	addq	$0x3, %r9
               	movslq	%r9d, %r9
               	addq	$0x7, %r9
               	movslq	%r9d, %r9
               	movq	%r11, %r8
               	addq	$0x8, %r8
               	movslq	%r8d, %r8
               	subq	$0x3, %r8
               	movslq	%r8d, %r8
               	movq	%r11, %rdi
               	subq	$0x4, %rdi
               	movslq	%edi, %rdi
               	addq	$0x9, %rdi
               	movslq	%edi, %rdi
               	movq	%r11, %rsi
               	subq	$0x2, %rsi
               	movslq	%esi, %rsi
               	subq	$0x5, %rsi
               	movslq	%esi, %rsi
               	movq	%r11, %rdx
               	andq	$0x3f, %rdx
               	movq	%r11, %rcx
               	orq	$0x3, %rcx
               	xorq	$0x3, %r11
               	movslq	%r9d, %r9
               	movslq	%r8d, %r8
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	movslq	%edi, %rdi
               	addq	%rdi, %r9
               	movslq	%r9d, %r9
               	movslq	%esi, %rsi
               	addq	%rsi, %r9
               	movslq	%r9d, %r9
               	movslq	%edx, %rdx
               	addq	%rdx, %r9
               	movslq	%r9d, %r9
               	movslq	%ecx, %rcx
               	addq	%rcx, %r9
               	movslq	%r9d, %r9
               	movslq	%r11d, %r11
               	addq	%r11, %r9
               	movslq	%r9d, %rbx
               	leaq	<rip>, %rdi
               	movslq	%ebx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%ebx, %rbx
               	cmpq	$0x53, %rbx
               	jne	<addr>
               	xorq	%rax, %rax
               	movq	%rax, -0x60(%rbp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%rax, -0x60(%rbp)
               	jmp	<addr>
               	movq	-0x60(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
