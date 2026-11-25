
getopt_long_permutes_operands.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0x1a8, %rsp            # imm = 0x1A8
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movzbq	0x4(%rcx), %r10
               	movb	%r10b, 0x4(%rax)
               	leaq	0x8(%rsp), %rcx
               	leaq	<rip>, %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	leaq	0x10(%rsp), %rdx
               	leaq	<rip>, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	leaq	0x18(%rsp), %rsi
               	leaq	<rip>, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	movzbq	0x4(%rdi), %r10
               	movb	%r10b, 0x4(%rsi)
               	leaq	0x20(%rsp), %rdi
               	leaq	<rip>, %r8
               	movl	(%r8), %r10d
               	movl	%r10d, (%rdi)
               	movzbq	0x4(%r8), %r10
               	movb	%r10b, 0x4(%rdi)
               	leaq	0x28(%rsp), %r8
               	leaq	<rip>, %r9
               	movl	(%r9), %r10d
               	movl	%r10d, (%r8)
               	leaq	0xb8(%rsp), %r8
               	leaq	<rip>, %r9
               	movq	(%r9), %r10
               	movq	%r10, (%r8)
               	movzwq	0x8(%r9), %r10
               	movw	%r10w, 0x8(%r8)
               	leaq	0x30(%rsp), %r8
               	leaq	<rip>, %r9
               	movl	(%r9), %r10d
               	movl	%r10d, (%r8)
               	movzwq	0x4(%r9), %r10
               	movw	%r10w, 0x4(%r8)
               	movzbq	0x6(%r9), %r10
               	movb	%r10b, 0x6(%r8)
               	leaq	0x38(%rsp), %r8
               	leaq	<rip>, %r9
               	movl	(%r9), %r10d
               	movl	%r10d, (%r8)
               	movzwq	0x4(%r9), %r10
               	movw	%r10w, 0x4(%r8)
               	movzbq	0x6(%r9), %r10
               	movb	%r10b, 0x6(%r8)
               	leaq	0x40(%rsp), %r8
               	leaq	<rip>, %r9
               	movzwq	(%r9), %r10
               	movw	%r10w, (%r8)
               	movzbq	0x2(%r9), %r10
               	movb	%r10b, 0x2(%r8)
               	leaq	0x48(%rsp), %r8
               	leaq	<rip>, %r9
               	movzwq	(%r9), %r10
               	movw	%r10w, (%r8)
               	movzbq	0x2(%r9), %r10
               	movb	%r10b, 0x2(%r8)
               	movq	%rax, 0x140(%rsp)
               	movq	%rcx, 0x148(%rsp)
               	movq	%rdx, 0x150(%rsp)
               	movq	%rsi, 0x158(%rsp)
               	movq	%rdi, 0x160(%rsp)
               	leaq	0x28(%rsp), %rax
               	movq	%rax, 0x168(%rsp)
               	leaq	0xb8(%rsp), %rax
               	movq	%rax, 0x170(%rsp)
               	leaq	0x30(%rsp), %rax
               	movq	%rax, 0x178(%rsp)
               	leaq	0x38(%rsp), %rax
               	movq	%rax, 0x180(%rsp)
               	leaq	0x40(%rsp), %rax
               	movq	%rax, 0x188(%rsp)
               	leaq	0x48(%rsp), %rax
               	movq	%rax, 0x190(%rsp)
               	movq	$0x0, 0x198(%rsp)
               	leaq	0x50(%rsp), %rcx
               	leaq	<rip>, %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movzbq	0x4(%rdx), %r10
               	movb	%r10b, 0x4(%rcx)
               	leaq	0x58(%rsp), %rdx
               	leaq	<rip>, %rsi
               	movzwq	(%rsi), %r10
               	movw	%r10w, (%rdx)
               	movzbq	0x2(%rsi), %r10
               	movb	%r10b, 0x2(%rdx)
               	leaq	0x60(%rsp), %rsi
               	leaq	<rip>, %rdi
               	movzwq	(%rdi), %r10
               	movw	%r10w, (%rsi)
               	movzbq	0x2(%rdi), %r10
               	movb	%r10b, 0x2(%rsi)
               	movq	%rcx, 0xc8(%rsp)
               	movq	%rdx, 0xd0(%rsp)
               	movq	%rsi, 0xd8(%rsp)
               	movq	$0x0, 0xe0(%rsp)
               	leaq	0x68(%rsp), %rcx
               	leaq	<rip>, %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movzbq	0x4(%rdx), %r10
               	movb	%r10b, 0x4(%rcx)
               	leaq	0x70(%rsp), %rdx
               	leaq	<rip>, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	movzwq	0x4(%rsi), %r10
               	movw	%r10w, 0x4(%rdx)
               	movzbq	0x6(%rsi), %r10
               	movb	%r10b, 0x6(%rdx)
               	leaq	0x78(%rsp), %rsi
               	leaq	<rip>, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0x80(%rsp), %rdi
               	leaq	<rip>, %r8
               	movzwq	(%r8), %r10
               	movw	%r10w, (%rdi)
               	movzbq	0x2(%r8), %r10
               	movb	%r10b, 0x2(%rdi)
               	movq	%rcx, 0xe8(%rsp)
               	movq	%rdx, 0xf0(%rsp)
               	movq	%rsi, 0xf8(%rsp)
               	movq	%rdi, 0x100(%rsp)
               	movq	$0x0, 0x108(%rsp)
               	leaq	0x88(%rsp), %rcx
               	leaq	<rip>, %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movzbq	0x4(%rdx), %r10
               	movb	%r10b, 0x4(%rcx)
               	leaq	0x90(%rsp), %rdx
               	leaq	<rip>, %rsi
               	movzwq	(%rsi), %r10
               	movw	%r10w, (%rdx)
               	movzbq	0x2(%rsi), %r10
               	movb	%r10b, 0x2(%rdx)
               	leaq	0x98(%rsp), %rsi
               	leaq	<rip>, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0xa0(%rsp), %rdi
               	leaq	<rip>, %r8
               	movzwq	(%r8), %r10
               	movw	%r10w, (%rdi)
               	movzbq	0x2(%r8), %r10
               	movb	%r10b, 0x2(%rdi)
               	leaq	0xa8(%rsp), %r8
               	leaq	<rip>, %r9
               	movzwq	(%r9), %r10
               	movw	%r10w, (%r8)
               	movzbq	0x2(%r9), %r10
               	movb	%r10b, 0x2(%r8)
               	movq	%rcx, 0x110(%rsp)
               	movq	%rdx, 0x118(%rsp)
               	movq	%rsi, 0x120(%rsp)
               	movq	%rdi, 0x128(%rsp)
               	movq	%r8, 0x130(%rsp)
               	movq	$0x0, 0x138(%rsp)
               	leaq	<rip>, %rdx
               	movl	$0xffffffff, 0xb0(%rsp) # imm = 0xFFFFFFFF
               	movq	<rip>, %rcx # <addr>
               	movl	$0x0, (%rcx)
               	movq	<rip>, %rcx # <addr>
               	movl	$0x0, (%rcx)
               	leaq	<rip>, %rcx # <addr>
               	movl	$0xb, %edi
               	leaq	0x140(%rsp), %rsi
               	leaq	0xb0(%rsp), %r8
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x61, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x1a8, %rsp            # imm = 0x1A8
               	retq
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rdx
               	movl	$0xb, %edi
               	leaq	0x140(%rsp), %rsi
               	leaq	0xb0(%rsp), %r8
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x62, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x1a8, %rsp            # imm = 0x1A8
               	retq
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rdx
               	movl	$0xb, %edi
               	leaq	0x140(%rsp), %rsi
               	leaq	0xb0(%rsp), %r8
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x42, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0xb0(%rsp), %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x1a8, %rsp            # imm = 0x1A8
               	retq
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rdx
               	movl	$0xb, %edi
               	leaq	0x140(%rsp), %rsi
               	leaq	0xb0(%rsp), %r8
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x47, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0xb0(%rsp), %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x1a8, %rsp            # imm = 0x1A8
               	retq
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rdx
               	movl	$0xb, %edi
               	leaq	0x140(%rsp), %rsi
               	leaq	0xb0(%rsp), %r8
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x63, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x1a8, %rsp            # imm = 0x1A8
               	retq
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rdx
               	movl	$0xb, %edi
               	leaq	0x140(%rsp), %rsi
               	leaq	0xb0(%rsp), %r8
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movl	0xb0(%rsp), %eax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x1a8, %rsp            # imm = 0x1A8
               	retq
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rdx
               	movl	$0xb, %edi
               	leaq	0x140(%rsp), %rsi
               	leaq	0xb0(%rsp), %r8
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x1a8, %rsp            # imm = 0x1A8
               	retq
               	movq	0x180(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x188(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x190(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x1a8, %rsp            # imm = 0x1A8
               	retq
               	movq	<rip>, %rax # <addr>
               	xorl	%r8d, %r8d
               	movl	%r8d, (%rax)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	movl	$0x3, %edi
               	leaq	0xc8(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x3f, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x78, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x1a8, %rsp            # imm = 0x1A8
               	retq
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	movl	$0x3, %edi
               	leaq	0xc8(%rsp), %rsi
               	xorl	%r8d, %r8d
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x3a, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x62, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x3, %ecx
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x1a8, %rsp            # imm = 0x1A8
               	retq
               	movl	$0x0, (%rax)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	movl	$0x4, %edi
               	leaq	0xe8(%rsp), %rsi
               	leaq	0xb0(%rsp), %r8
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x41, %rax
               	jne	<addr>
               	cmpl	$0x0, 0xb0(%rsp)
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x1a8, %rsp            # imm = 0x1A8
               	retq
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	movl	$0x4, %edi
               	leaq	0xe8(%rsp), %rsi
               	leaq	0xb0(%rsp), %r8
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x42, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x1a8, %rsp            # imm = 0x1A8
               	retq
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	movl	$0x4, %edi
               	leaq	0xe8(%rsp), %rsi
               	leaq	0xb0(%rsp), %r8
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x61, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x1a8, %rsp            # imm = 0x1A8
               	retq
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	movl	$0x4, %edi
               	leaq	0xe8(%rsp), %rsi
               	leaq	0xb0(%rsp), %r8
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x1a8, %rsp            # imm = 0x1A8
               	retq
               	movl	$0x1, (%rax)
               	leaq	<rip>, %rdx
               	movl	$0x5, %edi
               	leaq	0x110(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x61, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x1a8, %rsp            # imm = 0x1A8
               	retq
               	leaq	<rip>, %rdx
               	movl	$0x5, %edi
               	leaq	0x110(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x62, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x1a8, %rsp            # imm = 0x1A8
               	retq
               	leaq	<rip>, %rdx
               	movl	$0x5, %edi
               	leaq	0x110(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x61, %rax
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x5, %edi
               	leaq	0x110(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x1a8, %rsp            # imm = 0x1A8
               	retq
               	xorl	%eax, %eax
               	addq	$0x1a8, %rsp            # imm = 0x1A8
               	retq
