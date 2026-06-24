
slot_coalesce_declared.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<mkq>:
               	popq	%r10
               	subq	$0x20, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rsi, 0x10(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x20(%rbp), %rax
               	movq	0x20(%rbp), %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x20(%rbp), %rax
               	movq	0x20(%rbp), %rcx
               	xorq	$0x5555, %rcx           # imm = 0x5555
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x20(%rbp), %rax
               	movq	0x20(%rbp), %rcx
               	addq	$0x9, %rcx
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x20(%rbp), %rax
               	movq	0x20(%rbp), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	movq	%rcx, 0x18(%rax)
               	movq	0x10(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<useq>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rax
               	leaq	-0x20(%rbp), %rcx
               	movq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x20(%rbp), %rcx
               	movq	0x10(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x20(%rbp), %rcx
               	movq	0x18(%rcx), %rcx
               	addq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<simple>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	cmpq	%rdi, %rcx
               	jge	<addr>
               	jmp	<addr>
               	incq	%rcx
               	jmp	<addr>
               	leaq	(%rcx,%rcx,2), %rdx
               	addq	$0x7, %rdx
               	addq	%rdx, %rax
               	jmp	<addr>
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<heavy>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	cmpq	%rdi, %rcx
               	jge	<addr>
               	jmp	<addr>
               	incq	%rcx
               	jmp	<addr>
               	leaq	(%rcx,%rcx,2), %rdx
               	movl	$0x7, %esi
               	addq	%rdx, %rsi
               	addq	%rsi, %rax
               	leaq	(%rcx,%rcx), %rsi
               	addq	%rcx, %rsi
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	addq	%rdx, %rax
               	leaq	(%rcx,%rcx,8), %rdx
               	movq	%rdx, %r10
               	subq	%r10, %rdx
               	addq	%rdx, %rax
               	jmp	<addr>
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq

<sum8>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x40(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x38(%rbp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, -0x30(%rbp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, -0x28(%rbp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x50(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x58(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	leaq	-0x40(%rbp), %rax
               	movq	(%rax), %rax
               	leaq	-0x40(%rbp), %rcx
               	movq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x40(%rbp), %rcx
               	movq	0x10(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x40(%rbp), %rcx
               	movq	0x18(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x40(%rbp), %rcx
               	movq	0x20(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x40(%rbp), %rcx
               	movq	0x28(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x40(%rbp), %rcx
               	movq	0x30(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x40(%rbp), %rcx
               	movq	0x38(%rcx), %rcx
               	addq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<build>:
               	popq	%r10
               	subq	$0x20, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rsi, 0x10(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x140, %rsp            # imm = 0x140
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	0x20(%rbp), %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	movq	%rax, %rdx
               	addq	$0x2, %rdx
               	movq	%rax, %rsi
               	addq	$0x3, %rsi
               	movq	%rax, %rdi
               	addq	$0x4, %rdi
               	movq	%rax, %r8
               	addq	$0x5, %r8
               	movq	%rax, %r9
               	addq	$0x6, %r9
               	movq	%rax, %rbx
               	addq	$0x7, %rbx
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	addq	%rsi, %rax
               	addq	%rdi, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	addq	%rbx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	movq	%rax, %rdx
               	addq	$0x2, %rdx
               	movq	%rax, %rsi
               	addq	$0x3, %rsi
               	movq	%rax, %rdi
               	addq	$0x4, %rdi
               	movq	%rax, %r8
               	addq	$0x5, %r8
               	movq	%rax, %r9
               	addq	$0x6, %r9
               	movq	%rax, %rbx
               	addq	$0x7, %rbx
               	addq	%rax, %rcx
               	addq	%rdx, %rcx
               	addq	%rsi, %rcx
               	addq	%rdi, %rcx
               	addq	%r8, %rcx
               	addq	%r9, %rcx
               	addq	%rbx, %rcx
               	movq	%rcx, %rdx
               	incq	%rdx
               	movq	%rcx, %rsi
               	addq	$0x2, %rsi
               	movq	%rcx, %rdi
               	addq	$0x3, %rdi
               	movq	%rcx, %r8
               	addq	$0x4, %r8
               	movq	%rcx, %r9
               	addq	$0x5, %r9
               	movq	%rcx, %rbx
               	addq	$0x6, %rbx
               	movq	%rcx, %r12
               	addq	$0x7, %r12
               	addq	%rcx, %rdx
               	addq	%rsi, %rdx
               	addq	%rdi, %rdx
               	addq	%r8, %rdx
               	addq	%r9, %rdx
               	addq	%rbx, %rdx
               	addq	%r12, %rdx
               	movq	0x10(%rbp), %rsi
               	leaq	-0x118(%rbp), %rdi
               	leaq	<rip>, %r8
               	pushq	%rax
               	movq	(%r8), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%r8), %rax
               	movq	%rax, 0x8(%rdi)
               	movq	0x10(%r8), %rax
               	movq	%rax, 0x10(%rdi)
               	movq	0x18(%r8), %rax
               	movq	%rax, 0x18(%rdi)
               	movq	0x20(%r8), %rax
               	movq	%rax, 0x20(%rdi)
               	movq	0x28(%r8), %rax
               	movq	%rax, 0x28(%rdi)
               	movq	0x30(%r8), %rax
               	movq	%rax, 0x30(%rdi)
               	movq	0x38(%r8), %rax
               	movq	%rax, 0x38(%rdi)
               	popq	%rax
               	movq	0x20(%rbp), %rdi
               	leaq	-0x118(%rbp), %r8
               	movq	%rdi, (%r8)
               	movq	0x20(%rbp), %rdi
               	incq	%rdi
               	leaq	-0x118(%rbp), %r8
               	movq	%rdi, 0x8(%r8)
               	movq	0x20(%rbp), %rdi
               	addq	$0x2, %rdi
               	leaq	-0x118(%rbp), %r8
               	movq	%rdi, 0x10(%r8)
               	movq	0x20(%rbp), %rdi
               	addq	$0x3, %rdi
               	leaq	-0x118(%rbp), %r8
               	movq	%rdi, 0x18(%r8)
               	movq	0x20(%rbp), %rdi
               	addq	$0x4, %rdi
               	leaq	-0x118(%rbp), %r8
               	movq	%rdi, 0x20(%r8)
               	movq	0x20(%rbp), %rdi
               	addq	$0x5, %rdi
               	leaq	-0x118(%rbp), %r8
               	movq	%rdi, 0x28(%r8)
               	movq	0x20(%rbp), %rdi
               	addq	$0x6, %rdi
               	leaq	-0x118(%rbp), %r8
               	movq	%rdi, 0x30(%r8)
               	movq	0x20(%rbp), %rdi
               	movq	%rax, %r10
               	subq	%r10, %rax
               	addq	%rdi, %rax
               	movq	%rcx, %r10
               	subq	%r10, %rcx
               	addq	%rcx, %rax
               	movq	%rdx, %rcx
               	subq	%rdx, %rcx
               	addq	%rcx, %rax
               	leaq	-0x118(%rbp), %rcx
               	movq	%rax, 0x38(%rcx)
               	leaq	-0x118(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rsi)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%rsi)
               	movq	0x20(%rax), %rcx
               	movq	%rcx, 0x20(%rsi)
               	movq	0x28(%rax), %rcx
               	movq	%rcx, 0x28(%rsi)
               	movq	0x30(%rax), %rcx
               	movq	%rcx, 0x30(%rsi)
               	movq	0x38(%rax), %rcx
               	movq	%rcx, 0x38(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	%rsi, %rax
               	addq	$0x140, %rsp            # imm = 0x140
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1f0, %rsp            # imm = 0x1F0
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movl	$0x32, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r12
               	sete	%al
               	movzbq	%al, %rax
               	movl	$0x1234abcd, %ecx       # imm = 0x1234ABCD
               	movq	%rcx, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movq	(%rdx), %rsi
               	xorq	$0xfeed, %rsi           # imm = 0xFEED
               	movq	%rsi, (%rdx)
               	xorq	$0xfeed, %rcx           # imm = 0xFEED
               	movslq	%eax, %rax
               	xorq	%rbx, %rbx
               	testq	%rax, %rax
               	je	<addr>
               	movq	-0x10(%rbp), %rax
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	xorq	%r9, %r9
               	movq	%r9, %rax
               	movq	%r9, %rcx
               	movslq	%eax, %rdx
               	cmpq	$0x6, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%eax, %rax
               	incq	%rax
               	jmp	<addr>
               	leaq	-0x50(%rbp), %rdx
               	movslq	%eax, %rsi
               	movq	%rsi, %rdi
               	addq	$0x3e8, %rdi            # imm = 0x3E8
               	movslq	%edi, %rdi
               	movq	%rdi, (%rdx,%rsi,8)
               	movq	%rax, %rdx
               	addq	$0x3e8, %rdx            # imm = 0x3E8
               	movslq	%edx, %rdx
               	addq	%rdx, %rcx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	movslq	%edx, %rax
               	cmpq	$0x6, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rax
               	movq	%rax, %rdx
               	incq	%rdx
               	jmp	<addr>
               	leaq	-0x50(%rbp), %rax
               	movslq	%edx, %rsi
               	movq	(%rax,%rsi,8), %rax
               	addq	%rax, %r9
               	jmp	<addr>
               	movslq	%ebx, %rax
               	xorq	%rbx, %rbx
               	testq	%rax, %rax
               	je	<addr>
               	cmpq	%rcx, %r9
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	leaq	-0x170(%rbp), %rdi
               	movl	$0x7b, %esi
               	callq	<addr>
               	leaq	-0x170(%rbp), %rax
               	leaq	-0x90(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	movq	0x18(%rax), %rdx
               	movq	%rdx, 0x18(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movl	$0x579e, %r12d          # imm = 0x579E
               	movslq	%ebx, %rax
               	xorq	%rbx, %rbx
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x90(%rbp), %rdi
               	subq	$0x20, %rsp
               	movq	%rdi, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	%r12, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	xorq	%r12, %r12
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	-0x90(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0x7b, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	xorq	%rbx, %rbx
               	testq	%r12, %r12
               	je	<addr>
               	leaq	-0x90(%rbp), %rax
               	movq	0x18(%rax), %rax
               	cmpq	$0x171, %rax            # imm = 0x171
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	leaq	-0x1d0(%rbp), %rdi
               	movl	$0xa, %esi
               	callq	<addr>
               	leaq	-0x1d0(%rbp), %rax
               	leaq	-0xf8(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	movq	0x18(%rax), %rdx
               	movq	%rdx, 0x18(%rcx)
               	movq	0x20(%rax), %rdx
               	movq	%rdx, 0x20(%rcx)
               	movq	0x28(%rax), %rdx
               	movq	%rdx, 0x28(%rcx)
               	movq	0x30(%rax), %rdx
               	movq	%rdx, 0x30(%rcx)
               	movq	0x38(%rax), %rdx
               	movq	%rdx, 0x38(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movslq	%ebx, %rax
               	xorq	%rbx, %rbx
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0xf8(%rbp), %rdi
               	subq	$0x40, %rsp
               	movq	%rdi, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	0x20(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x28(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x30(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x38(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	cmpq	$0x65, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	movslq	%ebx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x1f0, %rsp            # imm = 0x1F0
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x1f0, %rsp            # imm = 0x1F0
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
