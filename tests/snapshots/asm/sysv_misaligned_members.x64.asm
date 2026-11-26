
sysv_misaligned_members.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x18, %rsp
               	movl	0x20(%rsp), %r10d
               	movl	%r10d, 0x8(%rsp)
               	movzbq	0x24(%rsp), %r10
               	movb	%r10b, 0xc(%rsp)
               	imulq	$0x3e8, %rdi, %rax      # imm = 0x3E8
               	movsbq	0x8(%rsp), %rcx
               	imulq	$0x64, %rcx, %rcx
               	addq	%rcx, %rax
               	movslq	0x9(%rsp), %rcx
               	addq	%rcx, %rax
               	addq	$0x18, %rsp
               	retq

<take_p2>:
               	subq	$0x18, %rsp
               	movl	0x20(%rsp), %r10d
               	movl	%r10d, 0x8(%rsp)
               	movzwq	0x24(%rsp), %r10
               	movw	%r10w, 0xc(%rsp)
               	movswq	0x8(%rsp), %rax
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	movl	0xa(%rsp), %ecx
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	$0x3, %rax
               	addq	$0x18, %rsp
               	retq

<take_p5>:
               	subq	$0x18, %rsp
               	movl	0x20(%rsp), %r10d
               	movl	%r10d, 0x8(%rsp)
               	movzwq	0x24(%rsp), %r10
               	movw	%r10w, 0xc(%rsp)
               	movsbq	0x8(%rsp), %rax
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	movl	0xa(%rsp), %ecx
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	$0x3, %rax
               	addq	$0x18, %rsp
               	retq

<make_p1>:
               	subq	$0x28, %rsp
               	movq	%rdi, (%rsp)
               	leaq	0x18(%rsp), %rcx
               	movb	$0x6, 0x18(%rsp)
               	movl	$0x4d, 0x19(%rsp)
               	movq	(%rsp), %rax
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movzbq	0x4(%rcx), %r10
               	movb	%r10b, 0x4(%rax)
               	addq	$0x28, %rsp
               	retq

<make_p2>:
               	subq	$0x28, %rsp
               	movq	%rdi, (%rsp)
               	leaq	0x18(%rsp), %rcx
               	movw	$0x4, 0x18(%rsp)
               	movl	$0xb, 0x1a(%rsp)
               	movq	(%rsp), %rax
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movzwq	0x4(%rcx), %r10
               	movw	%r10w, 0x4(%rax)
               	addq	$0x28, %rsp
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
               	subq	$0x38, %rsp
               	subq	$0x10, %rsp
               	leaq	0x20(%rsp), %rax
               	leaq	<rip>, %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	leaq	0x38(%rsp), %rax
               	leaq	<rip>, %rcx
               	movzwq	(%rcx), %r10
               	movw	%r10w, (%rax)
               	movzbq	0x2(%rcx), %r10
               	movb	%r10b, 0x2(%rax)
               	leaq	0x30(%rsp), %r9
               	movb	$0x1, 0x30(%rsp)
               	movl	$0x7, 0x31(%rsp)
               	movw	$0x2, 0x18(%rsp)
               	movl	$0x9, 0x1a(%rsp)
               	movw	$0x504, 0x28(%rsp)      # imm = 0x504
               	movl	$0x6, 0x2a(%rsp)
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
               	movl	$0x2a, %edi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	addq	$0x38, %rsp
               	retq
               	leaq	0x18(%rsp), %r9
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
               	movl	$0x2a, %edi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x10, %rsp
               	addq	$0x38, %rsp
               	retq
               	leaq	0x20(%rsp), %rdi
               	movl	$0x2a, %esi
               	movl	(%rdi), %edi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x10, %rsp
               	addq	$0x38, %rsp
               	retq
               	leaq	0x38(%rsp), %rdi
               	movl	$0x2a, %esi
               	movzwq	(%rdi), %r10
               	movzbq	0x2(%rdi), %r11
               	shlq	$0x10, %r11
               	orq	%r11, %r10
               	movq	%r10, %rdi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x10, %rsp
               	addq	$0x38, %rsp
               	retq
               	leaq	0x28(%rsp), %r9
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
               	movl	$0x2a, %edi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x10, %rsp
               	addq	$0x38, %rsp
               	retq
               	leaq	0x30(%rsp), %r9
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
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x10, %rsp
               	addq	$0x38, %rsp
               	retq
               	leaq	0x38(%rsp), %rdi
               	callq	<addr>
               	leaq	0x38(%rsp), %rax
               	leaq	0x30(%rsp), %rcx
               	movl	(%rax), %r10d
               	movl	%r10d, (%rcx)
               	movzbq	0x4(%rax), %r10
               	movb	%r10b, 0x4(%rcx)
               	movsbq	0x30(%rsp), %rax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movl	0x31(%rsp), %eax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x10, %rsp
               	addq	$0x38, %rsp
               	retq
               	leaq	-<rip>, %rdi # <addr>
               	callq	<addr>
               	cmpq	$0xdd6, %rax            # imm = 0xDD6
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x10, %rsp
               	addq	$0x38, %rsp
               	retq
               	leaq	0x18(%rsp), %r9
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
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpq	$0x82d, %rax            # imm = 0x82D
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x10, %rsp
               	addq	$0x38, %rsp
               	retq
               	leaq	0x28(%rsp), %r9
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
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpq	$0xfdf, %rax            # imm = 0xFDF
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x10, %rsp
               	addq	$0x38, %rsp
               	retq
               	leaq	0x38(%rsp), %rdi
               	movl	$0x6, %esi
               	movl	$0x4d, %edx
               	callq	<addr>
               	leaq	0x38(%rsp), %rdi
               	leaq	0x30(%rsp), %rax
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rax)
               	movzbq	0x4(%rdi), %r10
               	movb	%r10b, 0x4(%rax)
               	movsbq	0x30(%rsp), %rax
               	cmpl	$0x6, %eax
               	jne	<addr>
               	movl	0x31(%rsp), %eax
               	cmpl	$0x4d, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x10, %rsp
               	addq	$0x38, %rsp
               	retq
               	movl	$0x4, %esi
               	movl	$0xb, %edx
               	callq	<addr>
               	leaq	0x38(%rsp), %rax
               	leaq	0x18(%rsp), %rcx
               	movl	(%rax), %r10d
               	movl	%r10d, (%rcx)
               	movzwq	0x4(%rax), %r10
               	movw	%r10w, 0x4(%rcx)
               	movswq	0x18(%rsp), %rax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movl	0x1a(%rsp), %eax
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x10, %rsp
               	addq	$0x38, %rsp
               	retq
               	movl	$0x8, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	shrq	$0x8, %rdx
               	movq	%rax, %rsi
               	shrq	$0x10, %rsi
               	movq	%rax, %rcx
               	shrq	$0x18, %rcx
               	andq	$0xff, %rax
               	movb	%al, 0x20(%rsp)
               	andq	$0xff, %rdx
               	movb	%dl, 0x21(%rsp)
               	andq	$0xff, %rsi
               	movb	%sil, 0x22(%rsp)
               	andq	$0xff, %rcx
               	movb	%cl, 0x23(%rsp)
               	movsbq	%al, %rax
               	cmpl	$0x8, %eax
               	jne	<addr>
               	movsbq	%cl, %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x10, %rsp
               	addq	$0x38, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x10, %rsp
               	addq	$0x38, %rsp
               	retq
