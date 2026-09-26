
sysv_misaligned_members.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<take_p1>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movzbq	0x10(%rbp), %r10
               	movb	%r10b, -0x8(%rbp)
               	movzbq	0x11(%rbp), %r10
               	movb	%r10b, -0x7(%rbp)
               	movzbq	0x12(%rbp), %r10
               	movb	%r10b, -0x6(%rbp)
               	movzbq	0x13(%rbp), %r10
               	movb	%r10b, -0x5(%rbp)
               	movzbq	0x14(%rbp), %r10
               	movb	%r10b, -0x4(%rbp)
               	imulq	$0x3e8, %rdi, %rcx      # imm = 0x3E8
               	leaq	-0x8(%rbp), %rax
               	movsbq	(%rax), %rdx
               	imulq	$0x64, %rdx, %rdx
               	movslq	%edx, %rdx
               	addq	%rdx, %rcx
               	movslq	0x1(%rax), %rax
               	addq	%rcx, %rax
               	leave
               	retq

<take_p2>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movzbq	0x10(%rbp), %r10
               	movb	%r10b, -0x8(%rbp)
               	movzbq	0x11(%rbp), %r10
               	movb	%r10b, -0x7(%rbp)
               	movzbq	0x12(%rbp), %r10
               	movb	%r10b, -0x6(%rbp)
               	movzbq	0x13(%rbp), %r10
               	movb	%r10b, -0x5(%rbp)
               	movzbq	0x14(%rbp), %r10
               	movb	%r10b, -0x4(%rbp)
               	movzbq	0x15(%rbp), %r10
               	movb	%r10b, -0x3(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movswq	(%rax), %rcx
               	imulq	$0x3e8, %rcx, %rcx      # imm = 0x3E8
               	movslq	0x2(%rax), %rax
               	imulq	$0xa, %rax, %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	$0x3, %rax
               	leave
               	retq

<take_p5>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movzbq	0x10(%rbp), %r10
               	movb	%r10b, -0x8(%rbp)
               	movzbq	0x11(%rbp), %r10
               	movb	%r10b, -0x7(%rbp)
               	movzbq	0x12(%rbp), %r10
               	movb	%r10b, -0x6(%rbp)
               	movzbq	0x13(%rbp), %r10
               	movb	%r10b, -0x5(%rbp)
               	movzbq	0x14(%rbp), %r10
               	movb	%r10b, -0x4(%rbp)
               	movzbq	0x15(%rbp), %r10
               	movb	%r10b, -0x3(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movsbq	(%rax), %rcx
               	imulq	$0x3e8, %rcx, %rcx      # imm = 0x3E8
               	movslq	0x2(%rax), %rax
               	imulq	$0xa, %rax, %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	$0x3, %rax
               	leave
               	retq

<make_p1>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rdi, -0x40(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movb	$0x6, (%rcx)
               	movl	$0x4d, 0x1(%rcx)
               	movq	-0x40(%rbp), %rax
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movzbq	0x4(%rcx), %r10
               	movb	%r10b, 0x4(%rax)
               	leave
               	retq

<make_p2>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rdi, -0x40(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movw	$0x4, (%rcx)
               	movl	$0xb, 0x2(%rcx)
               	movq	-0x40(%rbp), %rax
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movzwq	0x4(%rcx), %r10
               	movw	%r10w, 0x4(%rax)
               	leave
               	retq

<make_p3>:
               	movl	$0x3020108, %eax        # imm = 0x3020108
               	retq

<after_p1>:
               	movq	%rdi, %rax
               	retq

<after_p2>:
               	movq	%rdi, %rax
               	retq

<after_p3>:
               	movq	%rsi, %rax
               	retq

<after_p4>:
               	movq	%rsi, %rax
               	retq

<after_p5>:
               	movq	%rdi, %rax
               	retq

<stack_p1>:
               	movl	0x9(%rsp), %eax
               	retq

<ret_p1>:
               	movb	$0x5, (%rdi)
               	movl	$0x2a, 0x1(%rdi)
               	movq	%rdi, %rax
               	retq

<via_p1>:
               	movq	%rdi, %rax
               	subq	$0x18, %rsp
               	movb	$0x5, (%rsp)
               	movl	$0x2a, 0x1(%rsp)
               	movq	$0x3, %rdi
               	callq	*%rax
               	addq	$0x18, %rsp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	movzwq	(%rcx), %r10
               	movw	%r10w, (%rax)
               	movzbq	0x2(%rcx), %r10
               	movb	%r10b, 0x2(%rax)
               	leaq	-0x40(%rbp), %r9
               	movb	$0x1, (%r9)
               	movl	$0x7, 0x1(%r9)
               	leaq	-0x38(%rbp), %rax
               	movw	$0x2, (%rax)
               	movl	$0x9, 0x2(%rax)
               	leaq	-0x28(%rbp), %rax
               	movb	$0x4, (%rax)
               	movb	$0x5, 0x1(%rax)
               	movl	$0x6, 0x2(%rax)
               	movl	$0x2a, %edi
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movzbq	(%r10), %r11
               	movb	%r11b, (%rsp)
               	movzbq	0x1(%r10), %r11
               	movb	%r11b, 0x1(%rsp)
               	movzbq	0x2(%r10), %r11
               	movb	%r11b, 0x2(%rsp)
               	movzbq	0x3(%r10), %r11
               	movb	%r11b, 0x3(%rsp)
               	movzbq	0x4(%r10), %r11
               	movb	%r11b, 0x4(%rsp)
               	callq	<addr>
               	addq	$0x10, %rsp
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x38(%rbp), %r9
               	movl	$0x2a, %edi
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movzbq	(%r10), %r11
               	movb	%r11b, (%rsp)
               	movzbq	0x1(%r10), %r11
               	movb	%r11b, 0x1(%rsp)
               	movzbq	0x2(%r10), %r11
               	movb	%r11b, 0x2(%rsp)
               	movzbq	0x3(%r10), %r11
               	movb	%r11b, 0x3(%rsp)
               	movzbq	0x4(%r10), %r11
               	movb	%r11b, 0x4(%rsp)
               	movzbq	0x5(%r10), %r11
               	movb	%r11b, 0x5(%rsp)
               	callq	<addr>
               	addq	$0x10, %rsp
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x30(%rbp), %rdi
               	movl	$0x2a, %esi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x2a, %esi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-0x28(%rbp), %r9
               	movl	$0x2a, %edi
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movzbq	(%r10), %r11
               	movb	%r11b, (%rsp)
               	movzbq	0x1(%r10), %r11
               	movb	%r11b, 0x1(%rsp)
               	movzbq	0x2(%r10), %r11
               	movb	%r11b, 0x2(%rsp)
               	movzbq	0x3(%r10), %r11
               	movb	%r11b, 0x3(%rsp)
               	movzbq	0x4(%r10), %r11
               	movb	%r11b, 0x4(%rsp)
               	movzbq	0x5(%r10), %r11
               	movb	%r11b, 0x5(%rsp)
               	callq	<addr>
               	addq	$0x10, %rsp
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	$0x3, %edi
               	leaq	-0x40(%rbp), %r9
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movzbq	(%r10), %r11
               	movb	%r11b, (%rsp)
               	movzbq	0x1(%r10), %r11
               	movb	%r11b, 0x1(%rsp)
               	movzbq	0x2(%r10), %r11
               	movb	%r11b, 0x2(%rsp)
               	movzbq	0x3(%r10), %r11
               	movb	%r11b, 0x3(%rsp)
               	movzbq	0x4(%r10), %r11
               	movb	%r11b, 0x4(%rsp)
               	callq	<addr>
               	addq	$0x10, %rsp
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x20(%rbp), %rax
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movzbq	0x4(%rcx), %r10
               	movb	%r10b, 0x4(%rax)
               	movsbq	(%rax), %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movslq	0x1(%rax), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-<rip>, %rdi      # <addr>
               	callq	<addr>
               	cmpq	$0xdd6, %rax            # imm = 0xDD6
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	-0x38(%rbp), %r9
               	movl	$0x3, %edi
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movzbq	(%r10), %r11
               	movb	%r11b, (%rsp)
               	movzbq	0x1(%r10), %r11
               	movb	%r11b, 0x1(%rsp)
               	movzbq	0x2(%r10), %r11
               	movb	%r11b, 0x2(%rsp)
               	movzbq	0x3(%r10), %r11
               	movb	%r11b, 0x3(%rsp)
               	movzbq	0x4(%r10), %r11
               	movb	%r11b, 0x4(%rsp)
               	movzbq	0x5(%r10), %r11
               	movb	%r11b, 0x5(%rsp)
               	callq	<addr>
               	addq	$0x10, %rsp
               	cmpq	$0x82d, %rax            # imm = 0x82D
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	-0x28(%rbp), %r9
               	movl	$0x3, %edi
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movzbq	(%r10), %r11
               	movb	%r11b, (%rsp)
               	movzbq	0x1(%r10), %r11
               	movb	%r11b, 0x1(%rsp)
               	movzbq	0x2(%r10), %r11
               	movb	%r11b, 0x2(%rsp)
               	movzbq	0x3(%r10), %r11
               	movb	%r11b, 0x3(%rsp)
               	movzbq	0x4(%r10), %r11
               	movb	%r11b, 0x4(%rsp)
               	movzbq	0x5(%r10), %r11
               	movb	%r11b, 0x5(%rsp)
               	callq	<addr>
               	addq	$0x10, %rsp
               	cmpq	$0xfdf, %rax            # imm = 0xFDF
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	movl	$0x6, %esi
               	movl	$0x4d, %edx
               	callq	<addr>
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	movl	(%rax), %r10d
               	movl	%r10d, (%rcx)
               	movzbq	0x4(%rax), %r10
               	movb	%r10b, 0x4(%rcx)
               	leaq	-0x20(%rbp), %rax
               	movsbq	(%rax), %rcx
               	cmpl	$0x6, %ecx
               	jne	<addr>
               	movslq	0x1(%rax), %rax
               	cmpl	$0x4d, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0xb, %edx
               	callq	<addr>
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x38(%rbp), %rcx
               	movl	(%rax), %r10d
               	movl	%r10d, (%rcx)
               	movzwq	0x4(%rax), %r10
               	movw	%r10w, 0x4(%rcx)
               	leaq	-0x38(%rbp), %rax
               	movswq	(%rax), %rcx
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	movslq	0x2(%rax), %rax
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movl	$0x8, %edi
               	callq	<addr>
               	movl	%eax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	movl	(%rax), %r10d
               	movl	%r10d, (%rcx)
               	leaq	-0x30(%rbp), %rax
               	movsbq	(%rax), %rcx
               	cmpl	$0x8, %ecx
               	jne	<addr>
               	movsbq	0x3(%rax), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
