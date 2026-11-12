
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
               	subq	$0x38, %rsp
               	pushq	%rbx
               	movl	$0x1e, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	xorl	%edi, %edi
               	movq	%rbx, %rsi
               	shlq	%rsi
               	movl	$0x3, %edx
               	movl	$0x22, %ecx
               	movq	$-0x1, %r8
               	movq	%rdi, %r9
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x18(%rsp), %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movq	0x18(%rsp), %rdi
               	addq	%rbx, %rdi
               	xorl	%edx, %edx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	0x18(%rsp), %rax
               	addq	%rbx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x10(%rbp), %rdi
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rdi)
               	movl	0x8(%rcx), %r10d
               	movl	%r10d, 0x8(%rdi)
               	leaq	-0x3(%rax), %rcx
               	leaq	-0x5(%rax), %rdx
               	leaq	-0x6(%rax), %rsi
               	leaq	-0x7(%rax), %r8
               	leaq	-0xb(%rax), %r9
               	leaq	-0xc(%rax), %rbx
               	movq	(%rdi), %r10
               	movq	%r10, (%rbx)
               	movl	0x8(%rdi), %r10d
               	movl	%r10d, 0x8(%rbx)
               	movsbq	(%rcx), %rax
               	movsbq	0x2(%rcx), %rdi
               	addq	%rdi, %rax
               	cmpl	$0x16, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movsbq	(%rdx), %rax
               	movsbq	0x4(%rdx), %rdi
               	addq	%rdi, %rax
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movswq	(%rsi), %rax
               	movswq	0x4(%rsi), %rdi
               	addq	%rdi, %rax
               	cmpl	$0x1412, %eax           # imm = 0x1412
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movsbq	(%r8), %rax
               	movsbq	0x6(%r8), %rdi
               	addq	%rdi, %rax
               	cmpl	$0x12, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movsbq	(%r9), %rax
               	movsbq	0xa(%r9), %rdi
               	addq	%rdi, %rax
               	cmpl	$0xe, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movzbq	0x6(%r8), %rax
               	movsbq	%al, %rax
               	cmpl	$0xc, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %edi
               	movzwq	(%rcx), %rax
               	movzbq	0x2(%rcx), %rcx
               	shlq	$0x10, %rcx
               	orq	%rcx, %rax
               	movl	(%rdx), %ecx
               	movzbq	0x4(%rdx), %rdx
               	shlq	$0x20, %rdx
               	orq	%rcx, %rdx
               	movl	(%rsi), %ecx
               	movzwq	0x4(%rsi), %rsi
               	shlq	$0x20, %rsi
               	orq	%rsi, %rcx
               	movl	(%r8), %esi
               	movzwq	0x4(%r8), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x18(%rsp), %r10
               	shlq	$0x20, %r10
               	movq	%r10, 0x18(%rsp)
               	orq	0x18(%rsp), %rsi
               	movzbq	0x6(%r8), %r8
               	shlq	$0x30, %r8
               	orq	%rsi, %r8
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
               	movq	%rax, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	cmpl	$0xc3c, %eax            # imm = 0xC3C
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3fc00000, (%rbx)     # imm = 0x3FC00000
               	movl	$0x40200000, 0x4(%rbx)  # imm = 0x40200000
               	movl	$0x40600000, 0x8(%rbx)  # imm = 0x40600000
               	movss	(%rbx), %xmm0
               	movss	0x8(%rbx), %xmm1
               	addss	%xmm1, %xmm0
               	movl	$0x40a00000, %ecx       # imm = 0x40A00000
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
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
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
