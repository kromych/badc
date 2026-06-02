
u16_load_store.x64:	file format elf64-x86-64

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
               	movq	%r12, 0x8(%rsp)
               	movslq	%edi, %rbx
               	leaq	<rip>, %r12
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r12, %r8
               	movq	(%r8), %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%r12, %rdi
               	movq	(%rdi), %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r8
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rsi
               	movq	%rsi, (%r8)
               	leaq	-0x18(%rbp), %rdx
               	addq	$0x8, %rdx
               	leaq	<rip>, %rsi
               	movq	%rsi, (%rdx)
               	leaq	-0x18(%rbp), %r8
               	addq	$0x10, %r8
               	leaq	<rip>, %rsi
               	movq	%rsi, (%r8)
               	leaq	-0x18(%rbp), %rdx
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	movq	(%rdx), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%r12, %rsi
               	movq	(%rax), %rax
               	movq	%rax, (%rsi)
               	jmp	<addr>
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	leaq	-0x10(%rbp), %r11
               	leaq	<rip>, %r9
               	pushq	%rax
               	movq	(%r9), %rax
               	movq	%rax, (%r11)
               	movzbq	0x8(%r9), %rax
               	movb	%al, 0x8(%r11)
               	movzbq	0x9(%r9), %rax
               	movb	%al, 0x9(%r11)
               	popq	%rax
               	leaq	-0x20(%rbp), %rdi
               	xorq	%rsi, %rsi
               	movl	$0xa, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x20(%rbp), %rax
               	addq	$0x2, %rax
               	movl	$0x4241, %edx           # imm = 0x4241
               	movw	%dx, (%rax)
               	leaq	-0x20(%rbp), %rsi
               	movzbq	(%rsi), %rsi
               	cmpq	$0x0, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	movq	%rsi, -0x40(%rbp)
               	cmpq	$0x0, %rsi
               	jne	<addr>
               	leaq	-0x20(%rbp), %rdx
               	addq	$0x1, %rdx
               	movzbq	(%rdx), %rdx
               	cmpq	$0x0, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, -0x40(%rbp)
               	jmp	<addr>
               	movq	-0x40(%rbp), %rdx
               	cmpq	$0x0, %rdx
               	je	<addr>
               	movl	$0x1, %esi
               	movq	%rsi, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rdx
               	addq	$0x2, %rdx
               	movzbq	(%rdx), %rdx
               	xorq	$0x41, %rdx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdx
               	cmpq	$0x0, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, -0x48(%rbp)
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	leaq	-0x20(%rbp), %rsi
               	addq	$0x3, %rsi
               	movzbq	(%rsi), %rsi
               	xorq	$0x42, %rsi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rsi
               	cmpq	$0x0, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	movq	%rsi, -0x48(%rbp)
               	jmp	<addr>
               	movq	-0x48(%rbp), %rsi
               	cmpq	$0x0, %rsi
               	je	<addr>
               	movl	$0x2, %edx
               	movq	%rdx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rsi
               	addq	$0x4, %rsi
               	movzbq	(%rsi), %rsi
               	cmpq	$0x0, %rsi
               	je	<addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rsi
               	addq	$0x1, %rsi
               	movzwq	(%rsi), %rsi
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	xorq	$0x4342, %rsi           # imm = 0x4342
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rsi
               	cmpq	$0x0, %rsi
               	je	<addr>
               	movl	$0x4, %edx
               	movq	%rdx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rsi, %rsi
               	movq	%rsi, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
