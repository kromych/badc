
for_init_decl_in_loop.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	<rip>, %r9
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	leaq	<rip>, %r9
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%r12, %r12
               	leaq	<rip>, %rdi
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	<rip>, %rdi
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	<rip>, %rdi
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r14
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %r12
               	movq	%r12, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	xorq	%r11, %r11
               	movl	%r11d, -0x8(%rbp)
               	movl	$0x1, %r9d
               	movl	%r9d, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %r9
               	cmpq	$0x5, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x10(%rbp), %r11
               	movslq	(%r11), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%r11)
               	jmp	<addr>
               	xorq	%r9, %r9
               	movl	%r9d, -0x18(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x18(%rbp), %r9
               	cmpq	$0x10, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x18(%rbp), %r8
               	movslq	(%r8), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%r8)
               	jmp	<addr>
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r9), %r11
               	movslq	-0x10(%rbp), %r8
               	movl	$0x64, %r10d
               	imulq	%r10, %r8
               	movslq	%r8d, %r8
               	movslq	-0x18(%rbp), %rdi
               	addq	%rdi, %r8
               	movslq	%r8d, %r8
               	addq	%r8, %r11
               	movl	%r11d, (%r9)
               	jmp	<addr>
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	cmpq	$0x4060, %rax           # imm = 0x4060
               	je	<addr>
               	movl	$0x1, %r9d
               	movq	%r9, %rax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
