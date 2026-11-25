
aggregate_argument_bounds.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	pushq	%rbx
               	subq	$0x10, %rsp
               	movl	$0x1e, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	xorl	%edi, %edi
               	movq	%rbx, %rsi
               	shlq	%rsi
               	movl	$0x3, %edx
               	movl	$0x22, %ecx
               	movq	$-0x1, %r8
               	movq	%rdi, %r9
               	callq	<addr>
               	movq	%rax, %rcx
               	cmpq	$-0x1, %rcx
               	je	<addr>
               	leaq	(%rcx,%rbx), %rdi
               	xorl	%edx, %edx
               	movq	%rcx, 0x28(%rsp)
               	movq	%rbx, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	0x28(%rsp), %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x40, %rsp
               	retq
               	leaq	(%rcx,%rbx), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movl	0x8(%rdx), %r10d
               	movl	%r10d, 0x8(%rcx)
               	leaq	-0xb(%rax), %r9
               	leaq	-0xc(%rax), %rbx
               	movq	(%rcx), %r10
               	movq	%r10, (%rbx)
               	movl	0x8(%rcx), %r10d
               	movl	%r10d, 0x8(%rbx)
               	movsbq	-0x3(%rax), %rdx
               	movsbq	-0x1(%rax), %rcx
               	addq	%rcx, %rdx
               	cmpl	$0x16, %edx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x40, %rsp
               	retq
               	movsbq	-0x5(%rax), %rdx
               	addq	%rcx, %rdx
               	cmpl	$0x14, %edx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x40, %rsp
               	retq
               	movswq	-0x6(%rax), %rdx
               	movswq	-0x2(%rax), %rsi
               	addq	%rsi, %rdx
               	cmpl	$0x1412, %edx           # imm = 0x1412
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x40, %rsp
               	retq
               	movsbq	-0x7(%rax), %rdx
               	addq	%rdx, %rcx
               	cmpl	$0x12, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x40, %rsp
               	retq
               	movsbq	(%r9), %rcx
               	movsbq	0xa(%r9), %rdx
               	addq	%rdx, %rcx
               	cmpl	$0xe, %ecx
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x40, %rsp
               	retq
               	movzbq	-0x1(%rax), %rcx
               	movsbq	%cl, %rdx
               	cmpl	$0xc, %edx
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x40, %rsp
               	retq
               	movl	$0x1, %edi
               	movzwq	-0x3(%rax), %r10
               	movq	%rcx, %rsi
               	shlq	$0x10, %rsi
               	orq	%r10, %rsi
               	movl	-0x5(%rax), %edx
               	shlq	$0x20, %rcx
               	orq	%rcx, %rdx
               	movl	-0x6(%rax), %ecx
               	movzwq	-0x2(%rax), %r8
               	shlq	$0x20, %r8
               	orq	%r8, %rcx
               	movl	-0x7(%rax), %r8d
               	shlq	$0x20, %r10
               	orq	%r10, %r8
               	movzbq	-0x1(%rax), %rax
               	shlq	$0x30, %rax
               	orq	%rax, %r8
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movzbq	0x8(%r10), %r11
               	movb	%r11b, 0x8(%rsp)
               	movzbq	0x9(%r10), %r11
               	movb	%r11b, 0x9(%rsp)
               	movzbq	0xa(%r10), %r11
               	movb	%r11b, 0xa(%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	cmpl	$0xc3c, %eax            # imm = 0xC3C
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x40, %rsp
               	retq
               	movabsq	$0x402000003fc00000, %rax # imm = 0x402000003FC00000
               	movq	%rax, (%rbx)
               	movl	$0x40600000, 0x8(%rbx)  # imm = 0x40600000
               	movss	(%rbx), %xmm0
               	vaddss	0x8(%rbx), %xmm0, %xmm0
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x40, %rsp
               	retq
               	movl	$0x40600000, 0x38(%rsp) # imm = 0x40600000
               	movss	0x38(%rsp), %xmm0
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x40, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x40, %rsp
               	retq
