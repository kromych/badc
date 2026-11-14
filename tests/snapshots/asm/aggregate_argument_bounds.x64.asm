
aggregate_argument_bounds.x64:	file format elf64-x86-64

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

<va>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rdi, -0xd0(%rbp)
               	movq	%rsi, -0xc8(%rbp)
               	movq	%rdx, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%r8, -0xb0(%rbp)
               	movq	%r9, -0xa8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movups	%xmm0, -0xa0(%rbp)
               	movups	%xmm1, -0x90(%rbp)
               	movups	%xmm2, -0x80(%rbp)
               	movups	%xmm3, -0x70(%rbp)
               	movups	%xmm4, -0x60(%rbp)
               	movups	%xmm5, -0x50(%rbp)
               	movups	%xmm6, -0x40(%rbp)
               	movups	%xmm7, -0x30(%rbp)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xd0(%rbp), %rcx
               	movl	$0x8, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rax
               	movzbq	0x2(%rax), %rax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rcx, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rcx
               	movzbq	0x4(%rcx), %rcx
               	leaq	-0x18(%rbp), %rdx
               	movq	%rdx, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rdx
               	movzwq	0x4(%rdx), %rdx
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rsi
               	movzbq	0x6(%rsi), %rsi
               	leaq	-0x18(%rbp), %rdi
               	movq	%rdi, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x28, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x10, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x10, 0x8(%r11)
               	movq	%r10, %rdi
               	movzbq	0xa(%rdi), %rdi
               	leaq	-0x18(%rbp), %r8
               	movl	-0xd0(%rbp), %r8d
               	movsbq	%al, %rax
               	addq	%r8, %rax
               	movsbq	%cl, %rcx
               	addq	%rcx, %rax
               	movswq	%dx, %rcx
               	addq	%rcx, %rax
               	movsbq	%sil, %rcx
               	addq	%rcx, %rax
               	movsbq	%dil, %rcx
               	addq	%rcx, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movl	$0x1e, %edi
               	callq	<addr>
               	movq	%rax, %r9
               	xorl	%edi, %edi
               	movq	%r9, %rsi
               	shlq	%rsi
               	movl	$0x3, %edx
               	movl	$0x22, %ecx
               	movq	$-0x1, %r8
               	movq	%r9, 0x10(%rsp)
               	movq	%rdi, %r9
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	0x10(%rsp), %r9
               	cmpq	$-0x1, %rcx
               	je	<addr>
               	leaq	(%rcx,%r9), %rdi
               	xorl	%edx, %edx
               	movq	%r9, 0x10(%rsp)
               	movq	%rcx, 0x8(%rsp)
               	movq	%r9, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	0x10(%rsp), %r9
               	movq	0x8(%rsp), %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	(%rcx,%r9), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x10(%rbp), %rdx
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rdx)
               	movl	0x8(%rcx), %r10d
               	movl	%r10d, 0x8(%rdx)
               	leaq	-0xb(%rax), %r9
               	leaq	-0xc(%rax), %rcx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movl	0x8(%rdx), %r10d
               	movl	%r10d, 0x8(%rcx)
               	movsbq	-0x3(%rax), %rsi
               	movsbq	-0x1(%rax), %rdx
               	addq	%rdx, %rsi
               	cmpl	$0x16, %esi
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movsbq	-0x5(%rax), %rsi
               	addq	%rdx, %rsi
               	cmpl	$0x14, %esi
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movswq	-0x6(%rax), %rsi
               	movswq	-0x2(%rax), %rdi
               	addq	%rdi, %rsi
               	cmpl	$0x1412, %esi           # imm = 0x1412
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movsbq	-0x7(%rax), %rsi
               	addq	%rsi, %rdx
               	cmpl	$0x12, %edx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movsbq	(%r9), %rdx
               	movsbq	0xa(%r9), %rsi
               	addq	%rsi, %rdx
               	cmpl	$0xe, %edx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movzbq	-0x1(%rax), %rdx
               	movsbq	%dl, %rsi
               	cmpl	$0xc, %esi
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movl	$0x1, %edi
               	movzwq	-0x3(%rax), %r8
               	movq	%rdx, %rsi
               	shlq	$0x10, %rsi
               	orq	%r8, %rsi
               	movl	-0x5(%rax), %r10d
               	movq	%r10, 0x28(%rsp)
               	shlq	$0x20, %rdx
               	movq	%rdx, %r10
               	movq	0x28(%rsp), %rdx
               	orq	%r10, %rdx
               	movl	-0x6(%rax), %r10d
               	movq	%r10, 0x28(%rsp)
               	movzwq	-0x2(%rax), %r10
               	movq	%r10, 0x20(%rsp)
               	shlq	$0x20, %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x28(%rsp), %r10
               	orq	0x20(%rsp), %r10
               	movq	%r10, 0x28(%rsp)
               	movl	-0x7(%rax), %r10d
               	movq	%r10, 0x20(%rsp)
               	shlq	$0x20, %r8
               	movq	%r8, %r10
               	movq	0x20(%rsp), %r8
               	orq	%r10, %r8
               	movzbq	-0x1(%rax), %rax
               	shlq	$0x30, %rax
               	orq	%rax, %r8
               	movq	%rcx, (%rsp)
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movzbq	0x8(%r10), %r11
               	movb	%r11b, 0x8(%rsp)
               	movzbq	0x9(%r10), %r11
               	movb	%r11b, 0x9(%rsp)
               	movzbq	0xa(%r10), %r11
               	movb	%r11b, 0xa(%rsp)
               	movq	0x38(%rsp), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	movq	(%rsp), %rcx
               	cmpl	$0xc3c, %eax            # imm = 0xC3C
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movabsq	$0x402000003fc00000, %rax # imm = 0x402000003FC00000
               	movq	%rax, (%rcx)
               	movl	$0x40600000, 0x8(%rcx)  # imm = 0x40600000
               	movss	(%rcx), %xmm0
               	movss	0x8(%rcx), %xmm1
               	addss	%xmm1, %xmm0
               	movl	$0x40a00000, %ecx       # imm = 0x40A00000
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movl	$0x40600000, -0x18(%rbp) # imm = 0x40600000
               	movss	-0x18(%rbp), %xmm0
               	movl	$0x40600000, %eax       # imm = 0x40600000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
