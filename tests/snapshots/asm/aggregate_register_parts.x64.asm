
aggregate_register_parts.x64:	file format elf64-x86-64

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

<by_value>:
               	movq	%rsi, %rdx
               	leaq	0x1(%rdi), %rax
               	retq

<make_pair>:
               	movq	%rdi, %rax
               	movq	%rsi, %rdx
               	retq

<swapq>:
               	rorxq	$0x20, %rdi, %rax
               	retq

<tail>:
               	movslq	%esi, %rax
               	addq	%rdi, %rax
               	shlq	%rsi
               	movl	%esi, %edx
               	retq

<bytes>:
               	movq	%rdi, %rax
               	shrq	$0x8, %rax
               	movq	%rdi, %rcx
               	shrq	$0x10, %rcx
               	movsbq	%dil, %rdx
               	incq	%rdx
               	movsbq	%al, %rax
               	addq	$0x2, %rax
               	movsbq	%cl, %rcx
               	addq	$0x3, %rcx
               	andq	$0xff, %rdx
               	andq	$0xff, %rax
               	shlq	$0x8, %rax
               	orq	%rdx, %rax
               	andq	$0xff, %rcx
               	shlq	$0x10, %rcx
               	orq	%rcx, %rax
               	retq

<mixed>:
               	movq	%rdi, %rdx
               	shrq	$0x10, %rdx
               	movq	%rdi, %rax
               	shrq	$0x20, %rax
               	movsbq	%dil, %rcx
               	leaq	0x1(%rcx), %rdi
               	movsbq	%dil, %rdi
               	movswq	%dx, %rdx
               	addq	%rdx, %rcx
               	movswq	%cx, %rcx
               	leaq	(%rax,%rdx), %r8
               	movslq	%eax, %rax
               	leaq	(%rsi,%rax), %rdx
               	andq	$0xff, %rdi
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	shlq	$0x10, %rcx
               	movq	%rdi, %rax
               	orq	%rcx, %rax
               	shlq	$0x20, %r8
               	orq	%r8, %rax
               	retq

<dsum>:
               	vaddsd	%xmm1, %xmm0, %xmm2
               	vsubsd	%xmm1, %xmm0, %xmm1
               	movapd	%xmm2, %xmm0
               	retq

<rot3>:
               	subq	$0x28, %rsp
               	movsd	%xmm0, 0x10(%rsp)
               	movsd	%xmm1, 0x18(%rsp)
               	leaq	(%rsp), %rax
               	movss	0x14(%rsp), %xmm0
               	movss	%xmm0, (%rsp)
               	movss	0x18(%rsp), %xmm0
               	movss	%xmm0, 0x4(%rsp)
               	movss	0x10(%rsp), %xmm0
               	movss	%xmm0, 0x8(%rsp)
               	movq	%rax, %rcx
               	movsd	(%rcx), %xmm0
               	movss	0x8(%rcx), %xmm1
               	addq	$0x28, %rsp
               	retq

<twice>:
               	vmulss	<rip>, %xmm0, %xmm0
               	retq

<dl>:
               	vmulsd	<rip>, %xmm0, %xmm0
               	leaq	0x1(%rdi), %rax
               	retq

<fi>:
               	subq	$0x18, %rsp
               	movq	%rdi, 0x8(%rsp)
               	movss	0x8(%rsp), %xmm0
               	vaddss	<rip>, %xmm0, %xmm0
               	movss	%xmm0, 0x8(%rsp)
               	addl	$0x1, 0xc(%rsp)
               	movq	0x8(%rsp), %rax
               	addq	$0x18, %rsp
               	retq

<ubump>:
               	leaq	0x1(%rdi), %rax
               	retq

<w1>:
               	movsbq	%dil, %rax
               	incq	%rax
               	andq	$0xff, %rax
               	retq

<w2>:
               	movswq	%di, %rax
               	incq	%rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	retq

<w4>:
               	leaq	0x1(%rdi), %rax
               	movl	%eax, %eax
               	retq

<w8>:
               	leaq	0x1(%rdi), %rax
               	retq

<nested>:
               	movslq	%edi, %rax
               	leaq	(%rsi,%rax), %rdx
               	rorxq	$0x20, %rdi, %rax
               	retq

<pp>:
               	leaq	0x4(%rdi), %rax
               	leaq	-0x1(%rsi), %rdx
               	retq

<big>:
               	subq	$0x38, %rsp
               	movq	%rdi, (%rsp)
               	movq	0x40(%rsp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x48(%rsp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x50(%rsp), %r10
               	movq	%r10, 0x28(%rsp)
               	leaq	0x18(%rsp), %rcx
               	movq	0x28(%rsp), %rax
               	movq	0x18(%rsp), %rdx
               	movq	0x20(%rsp), %rsi
               	addq	%rsi, %rdx
               	addq	%rdx, %rax
               	movq	%rax, 0x28(%rsp)
               	movq	(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	addq	$0x38, %rsp
               	retq

<sum_via_ptr>:
               	movq	(%rdi), %rax
               	movq	0x8(%rdi), %rcx
               	addq	%rcx, %rax
               	retq

<bump_via_ptr>:
               	addq	$0xa, (%rdi)
               	addq	$0x14, 0x8(%rdi)
               	retq

<escape>:
               	subq	$0x18, %rsp
               	movq	%rdi, (%rsp)
               	leaq	(%rsp), %rdi
               	movq	%rsi, 0x8(%rsp)
               	callq	<addr>
               	addq	$0x18, %rsp
               	retq

<escape_ret>:
               	subq	$0x18, %rsp
               	movq	%rdi, (%rsp)
               	leaq	(%rsp), %rdi
               	movq	%rsi, 0x8(%rsp)
               	callq	<addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rdx
               	addq	$0x18, %rsp
               	retq

<forward>:
               	pushq	%rax
               	callq	<addr>
               	popq	%r11
               	retq

<pick>:
               	pushq	%rax
               	testl	%edx, %edx
               	je	<addr>
               	movq	%rdi, %rax
               	movq	%rsi, %rdx
               	popq	%r11
               	retq
               	xchgq	%rsi, %rdi
               	callq	<addr>
               	popq	%r11
               	retq

<live>:
               	subq	$0x10, %rsp
               	pushq	%rbx
               	leaq	(%rdx,%rdx,2), %rbx
               	callq	<addr>
               	addq	%rbx, %rax
               	addq	%rdx, %rax
               	popq	%rbx
               	addq	$0x10, %rsp
               	retq

<ret_global>:
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rdx # <addr>
               	retq

<lit>:
               	movq	%rdi, %rax
               	leaq	0x1(%rax), %rdx
               	retq

<rec>:
               	pushq	%rax
               	movslq	%edx, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movq	%rdi, %rax
               	movq	%rsi, %rdx
               	popq	%r11
               	retq
               	leaq	(%rdi,%rdx), %rax
               	decq	%rdx
               	movq	%rax, %rdi
               	callq	<addr>
               	popq	%r11
               	retq

<loop>:
               	leaq	(%rdi,%rsi), %rax
               	leaq	(%rdi,%rax), %rcx
               	addq	%rsi, %rax
               	addq	%rax, %rcx
               	addq	%rsi, %rax
               	addq	%rcx, %rax
               	retq

<spill>:
               	subq	$0x18, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	movq	%rdx, %rbx
               	imulq	%rcx, %rbx
               	movq	%r8, %r12
               	imulq	%r9, %r12
               	movq	0x50(%rsp), %rax
               	movq	0x58(%rsp), %r13
               	movq	%rax, %r14
               	imulq	%r13, %r14
               	addq	%r8, %rdx
               	leaq	(%rdx,%rax), %r15
               	leaq	(%rcx,%r9), %rax
               	addq	%rax, %r13
               	movq	%rbx, %rbp
               	xorq	%r12, %rbp
               	movq	%r14, %r10
               	xorq	%r15, %r10
               	movq	%r10, 0x38(%rsp)
               	imulq	$0x7, %r13, %r10
               	movq	%r10, 0x30(%rsp)
               	callq	<addr>
               	leaq	(%rbx,%r12), %rcx
               	addq	%r14, %rcx
               	addq	%r15, %rcx
               	addq	%r13, %rcx
               	addq	%rbp, %rcx
               	addq	0x38(%rsp), %rcx
               	addq	0x30(%rsp), %rcx
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x18, %rsp
               	retq

<self_assign>:
               	movq	%rdi, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	retq

<lo128>:
               	leaq	(%rdi,%rdx), %rax
               	retq

<bump128>:
               	leaq	0x1(%rdi), %rax
               	cmpq	%rdi, %rax
               	setb	%cl
               	movzbq	%cl, %rcx
               	leaq	(%rsi,%rcx), %rdx
               	retq

<named_va>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xe0, %rsp
               	movq	%rdi, -0xe0(%rbp)
               	movq	%rsi, -0xd8(%rbp)
               	movq	%rdx, -0xd0(%rbp)
               	movq	%rcx, -0xc8(%rbp)
               	movq	%r8, -0xc0(%rbp)
               	movq	%r9, -0xb8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movups	%xmm0, -0xb0(%rbp)
               	movups	%xmm1, -0xa0(%rbp)
               	movups	%xmm2, -0x90(%rbp)
               	movups	%xmm3, -0x80(%rbp)
               	movups	%xmm4, -0x70(%rbp)
               	movups	%xmm5, -0x60(%rbp)
               	movups	%xmm6, -0x50(%rbp)
               	movups	%xmm7, -0x40(%rbp)
               	movq	%rsi, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	leaq	-0x28(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	$0x18, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xe0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	-0x28(%rbp), %rax
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
               	movq	(%rax), %rax
               	leaq	-0x28(%rbp), %rcx
               	movq	-0x8(%rbp), %rcx
               	imulq	$0x3e8, %rcx, %rcx      # imm = 0x3E8
               	movq	-0x10(%rbp), %rdx
               	addq	%rdx, %rcx
               	imulq	$0x7, %rax, %rax
               	addq	%rcx, %rax
               	movq	-0xe0(%rbp), %rcx
               	addq	%rcx, %rax
               	leave
               	retq

<sink>:
               	movq	%rdi, <rip> # <addr>
               	leaq	0x1(%rdi), %rax
               	retq

<const_across>:
               	pushq	%rax
               	callq	<addr>
               	movl	$0x7, %eax
               	movl	$0x8, %edx
               	popq	%r11
               	retq

<keep_across>:
               	pushq	%rax
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rdx, %rdi
               	movq	%rsi, %r12
               	callq	<addr>
               	movq	%rbx, %rax
               	movq	%r12, %rdx
               	popq	%rbx
               	popq	%r12
               	popq	%r11
               	retq

<va_ret>:
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
               	movq	(%rax), %rax
               	movslq	-0xd0(%rbp), %rdx
               	leaq	-0x18(%rbp), %rcx
               	leave
               	retq

<main>:
               	subq	$0xc8, %rsp
               	subq	$0x20, %rsp
               	movl	$0x7, %eax
               	movl	$0xb, %ecx
               	leaq	0x68(%rsp), %rdx
               	leaq	<rip>, %rsi
               	movzwq	(%rsi), %r10
               	movw	%r10w, (%rdx)
               	movzbq	0x2(%rsi), %r10
               	movb	%r10b, 0x2(%rdx)
               	leaq	0x80(%rsp), %rdx
               	leaq	<rip>, %rsi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x90(%rsp), %rdx
               	leaq	<rip>, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	movl	0x8(%rsi), %r10d
               	movl	%r10d, 0x8(%rdx)
               	leaq	0x70(%rsp), %rdx
               	leaq	<rip>, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	leaq	0xb8(%rsp), %rdx
               	leaq	<rip>, %rsi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x78(%rsp), %rdx
               	leaq	<rip>, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	leaq	0xa0(%rsp), %rdx
               	leaq	<rip>, %rsi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	%rax, %rdi
               	movq	%rcx, %rsi
               	callq	<addr>
               	movq	%rax, 0xd0(%rsp)
               	movq	%rdx, 0xd8(%rsp)
               	cmpq	$0x8, %rax
               	jne	<addr>
               	cmpq	$0xb, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	addq	$0xc8, %rsp
               	retq
               	movl	$0x15, %edi
               	movl	$0x16, %esi
               	callq	<addr>
               	movq	%rax, 0xd0(%rsp)
               	movq	%rdx, 0xd8(%rsp)
               	cmpq	$0x15, %rax
               	jne	<addr>
               	cmpq	$0x16, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	addq	$0xc8, %rsp
               	retq
               	leaq	0xd8(%rsp), %rdi
               	movabsq	$0x400000003, %rax      # imm = 0x400000003
               	movq	%rax, 0xd8(%rsp)
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, 0xd8(%rsp)
               	movl	0xd8(%rsp), %eax
               	movl	0xdc(%rsp), %ecx
               	cmpl	$0x4, %eax
               	jne	<addr>
               	cmpl	$0x3, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	addq	$0xc8, %rsp
               	retq
               	movl	$0x6, %eax
               	movl	$0x5, %ecx
               	movq	%rcx, %rdi
               	movq	%rax, %rsi
               	callq	<addr>
               	movq	%rax, 0xd0(%rsp)
               	movq	%rdx, 0xd8(%rsp)
               	movl	0xd8(%rsp), %ecx
               	cmpq	$0xb, %rax
               	jne	<addr>
               	cmpl	$0xc, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	addq	$0xc8, %rsp
               	retq
               	leaq	0x68(%rsp), %rdi
               	movzwq	(%rdi), %r10
               	movzbq	0x2(%rdi), %r11
               	shlq	$0x10, %r11
               	orq	%r11, %r10
               	movq	%r10, %rdi
               	callq	<addr>
               	movw	%ax, 0xd8(%rsp)
               	shrq	$0x10, %rax
               	movb	%al, 0xda(%rsp)
               	leaq	0xd8(%rsp), %rax
               	leaq	0x68(%rsp), %rcx
               	movzwq	(%rax), %r10
               	movw	%r10w, (%rcx)
               	movzbq	0x2(%rax), %r10
               	movb	%r10b, 0x2(%rcx)
               	movsbq	0x68(%rsp), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movsbq	0x69(%rsp), %rax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movsbq	0x6a(%rsp), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	addq	$0xc8, %rsp
               	retq
               	movabsq	$0x300020001, %rax      # imm = 0x300020001
               	movl	$0x4, %ecx
               	movq	%rax, %rdi
               	movq	%rcx, %rsi
               	callq	<addr>
               	movq	%rax, 0xd0(%rsp)
               	movq	%rdx, 0xd8(%rsp)
               	movzbq	0xd0(%rsp), %rax
               	movzwq	0xd2(%rsp), %rcx
               	movl	0xd4(%rsp), %esi
               	movsbq	%al, %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movswq	%cx, %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	cmpl	$0x5, %esi
               	jne	<addr>
               	cmpq	$0x7, %rdx
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x20, %rsp
               	addq	$0xc8, %rsp
               	retq
               	movsd	0x80(%rsp), %xmm0
               	movsd	0x88(%rsp), %xmm1
               	callq	<addr>
               	movsd	%xmm0, 0xd0(%rsp)
               	movsd	%xmm1, 0xd8(%rsp)
               	leaq	0xd0(%rsp), %rax
               	leaq	0x80(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x80(%rsp), %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	0x88(%rsp), %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x20, %rsp
               	addq	$0xc8, %rsp
               	retq
               	leaq	0x90(%rsp), %r9
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	movss	0x8(%r10), %xmm1
               	callq	<addr>
               	movsd	%xmm0, 0xd0(%rsp)
               	movss	%xmm1, 0xd8(%rsp)
               	leaq	0xd0(%rsp), %rax
               	leaq	0x90(%rsp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movl	0x8(%rax), %r10d
               	movl	%r10d, 0x8(%rcx)
               	movss	0x90(%rsp), %xmm0
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0x94(%rsp), %xmm0
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0x98(%rsp), %xmm0
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x20, %rsp
               	addq	$0xc8, %rsp
               	retq
               	leaq	0x70(%rsp), %r9
               	movq	%r9, %r10
               	movss	(%r10), %xmm0
               	callq	<addr>
               	movss	%xmm0, 0xd8(%rsp)
               	leaq	0xd8(%rsp), %rax
               	leaq	0x70(%rsp), %rcx
               	movl	(%rax), %r10d
               	movl	%r10d, (%rcx)
               	movss	0x70(%rsp), %xmm0
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x20, %rsp
               	addq	$0xc8, %rsp
               	retq
               	movsd	0xb8(%rsp), %xmm0
               	movq	0xc0(%rsp), %rax
               	movq	%rax, %rdi
               	callq	<addr>
               	movsd	%xmm0, 0xd0(%rsp)
               	movq	%rax, 0xd8(%rsp)
               	leaq	0xd0(%rsp), %rax
               	leaq	0xb8(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0xb8(%rsp), %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	0xc0(%rsp), %rax
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x20, %rsp
               	addq	$0xc8, %rsp
               	retq
               	leaq	0x78(%rsp), %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, 0xd8(%rsp)
               	leaq	0x78(%rsp), %rcx
               	movq	%rax, (%rcx)
               	movss	0x78(%rsp), %xmm0
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	0x7c(%rsp), %eax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x20, %rsp
               	addq	$0xc8, %rsp
               	retq
               	movl	$0x29, %edi
               	callq	<addr>
               	movq	%rax, 0xd8(%rsp)
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x20, %rsp
               	addq	$0xc8, %rsp
               	retq
               	leaq	0xd8(%rsp), %rdi
               	movb	$0x5, 0xd8(%rsp)
               	movzbq	(%rdi), %rdi
               	callq	<addr>
               	movb	%al, 0xd8(%rsp)
               	movq	%rax, %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x58(%rsp)
               	leaq	0xd8(%rsp), %rdi
               	movw	$0x258, 0xd8(%rsp)      # imm = 0x258
               	movzwq	(%rdi), %rdi
               	callq	<addr>
               	movw	%ax, 0xd8(%rsp)
               	movq	%rax, %r10
               	andq	$0xffff, %r10           # imm = 0xFFFF
               	movq	%r10, 0x50(%rsp)
               	leaq	0xd8(%rsp), %rdi
               	movl	$0x11170, 0xd8(%rsp)    # imm = 0x11170
               	movl	(%rdi), %edi
               	callq	<addr>
               	movl	%eax, 0xd8(%rsp)
               	movl	%eax, %r10d
               	movq	%r10, 0x48(%rsp)
               	movabsq	$0x1dcd65000, %rdi      # imm = 0x1DCD65000
               	callq	<addr>
               	movq	%rax, 0xd8(%rsp)
               	movq	0x58(%rsp), %rcx
               	movsbq	%cl, %rcx
               	cmpl	$0x6, %ecx
               	jne	<addr>
               	movq	0x50(%rsp), %rcx
               	movswq	%cx, %rcx
               	cmpl	$0x259, %ecx            # imm = 0x259
               	jne	<addr>
               	movq	0x48(%rsp), %rcx
               	cmpl	$0x11171, %ecx          # imm = 0x11171
               	jne	<addr>
               	movabsq	$0x1dcd65001, %r11      # imm = 0x1DCD65001
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x20, %rsp
               	addq	$0xc8, %rsp
               	retq
               	movabsq	$0x200000001, %rax      # imm = 0x200000001
               	movl	$0x1e, %ecx
               	movq	%rax, %rdi
               	movq	%rcx, %rsi
               	callq	<addr>
               	movq	%rax, 0xd0(%rsp)
               	movq	%rdx, 0xd8(%rsp)
               	movl	0xd0(%rsp), %eax
               	movl	0xd4(%rsp), %ecx
               	cmpl	$0x2, %eax
               	jne	<addr>
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	cmpq	$0x1f, %rdx
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x20, %rsp
               	addq	$0xc8, %rsp
               	retq
               	leaq	0xa0(%rsp), %rax
               	movl	$0x4, %ecx
               	movq	%rax, %rdi
               	movq	%rcx, %rsi
               	callq	<addr>
               	movq	%rax, 0xd0(%rsp)
               	movq	%rdx, 0xd8(%rsp)
               	leaq	0xa0(%rsp), %rcx
               	addq	$0x4, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	cmpq	$0x3, %rdx
               	jne	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x20, %rsp
               	addq	$0xc8, %rsp
               	retq
               	leaq	0xb0(%rsp), %rdi
               	leaq	0xc8(%rsp), %r9
               	movq	$0x1, 0xc8(%rsp)
               	movq	$0x2, 0xd0(%rsp)
               	movq	$0x3, 0xd8(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	callq	<addr>
               	movq	0xb0(%rsp), %rax
               	movq	0xb8(%rsp), %rcx
               	movq	0xc0(%rsp), %rdx
               	cmpq	$0x1, %rax
               	jne	<addr>
               	cmpq	$0x2, %rcx
               	jne	<addr>
               	cmpq	$0x6, %rdx
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x20, %rsp
               	addq	$0xc8, %rsp
               	retq
               	movl	$0x7, %eax
               	movl	$0xb, %ecx
               	movq	%rax, %rdi
               	movq	%rcx, %rsi
               	callq	<addr>
               	cmpq	$0x12, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x20, %rsp
               	addq	$0xc8, %rsp
               	retq
               	movl	$0x7, %eax
               	movl	$0xb, %ecx
               	movq	%rax, %rdi
               	movq	%rcx, %rsi
               	callq	<addr>
               	movq	%rax, 0xd0(%rsp)
               	movq	%rdx, 0xd8(%rsp)
               	cmpq	$0x11, %rax
               	jne	<addr>
               	cmpq	$0x1f, %rdx
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x20, %rsp
               	addq	$0xc8, %rsp
               	retq
               	movq	%rax, %rdi
               	movq	%rdx, %rsi
               	callq	<addr>
               	movq	%rax, 0xd0(%rsp)
               	movq	%rdx, 0xd8(%rsp)
               	cmpq	$0x12, %rax
               	jne	<addr>
               	cmpq	$0x1f, %rdx
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x20, %rsp
               	addq	$0xc8, %rsp
               	retq
               	movl	$0x1, %ecx
               	movq	%rax, %rdi
               	movq	%rdx, %rsi
               	movq	%rcx, %rdx
               	callq	<addr>
               	movq	%rax, 0xd0(%rsp)
               	movq	%rdx, 0xd8(%rsp)
               	cmpq	$0x12, %rax
               	jne	<addr>
               	cmpq	$0x1f, %rdx
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x20, %rsp
               	addq	$0xc8, %rsp
               	retq
               	xorl	%ecx, %ecx
               	movq	%rax, %rdi
               	movq	%rdx, %rsi
               	movq	%rcx, %rdx
               	callq	<addr>
               	movq	%rax, 0xd0(%rsp)
               	movq	%rdx, 0xd8(%rsp)
               	cmpq	$0x1f, %rax
               	jne	<addr>
               	cmpq	$0x12, %rdx
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x20, %rsp
               	addq	$0xc8, %rsp
               	retq
               	movl	$0x2, %ecx
               	movq	%rax, %rdi
               	movq	%rdx, %rsi
               	movq	%rcx, %rdx
               	callq	<addr>
               	cmpq	$0x38, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x20, %rsp
               	addq	$0xc8, %rsp
               	retq
               	callq	<addr>
               	movq	%rax, 0xd0(%rsp)
               	movq	%rdx, 0xd8(%rsp)
               	cmpq	$0x64, %rax
               	jne	<addr>
               	cmpq	$0xc8, %rdx
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0x20, %rsp
               	addq	$0xc8, %rsp
               	retq
               	movl	$0x5, %edi
               	callq	<addr>
               	movq	%rax, 0xd0(%rsp)
               	movq	%rdx, 0xd8(%rsp)
               	cmpq	$0x5, %rax
               	jne	<addr>
               	cmpq	$0x6, %rdx
               	je	<addr>
               	movl	$0x18, %eax
               	addq	$0x20, %rsp
               	addq	$0xc8, %rsp
               	retq
               	movl	$0x4, %ecx
               	movq	%rax, %rdi
               	movq	%rdx, %rsi
               	movq	%rcx, %rdx
               	callq	<addr>
               	movq	%rax, 0xd0(%rsp)
               	movq	%rdx, 0xd8(%rsp)
               	cmpq	$0xf, %rax
               	jne	<addr>
               	cmpq	$0x6, %rdx
               	je	<addr>
               	movl	$0x19, %eax
               	addq	$0x20, %rsp
               	addq	$0xc8, %rsp
               	retq
               	movq	%rax, 0x40(%rsp)
               	movq	%rdx, 0x38(%rsp)
               	movq	%rax, %rdi
               	movq	%rdx, %rsi
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	0x40(%rsp), %rax
               	movq	0x38(%rsp), %rdx
               	cmpq	$0x60, %rcx
               	je	<addr>
               	movl	$0x1a, %eax
               	addq	$0x20, %rsp
               	addq	$0xc8, %rsp
               	retq
               	movl	$0x1, %esi
               	movl	$0x2, %ecx
               	movl	$0x3, %r8d
               	movl	$0x4, %r9d
               	movq	%rax, 0x40(%rsp)
               	movq	%rdx, 0x38(%rsp)
               	movq	$0x5, (%rsp)
               	movq	$0x6, 0x8(%rsp)
               	movq	%rax, %rdi
               	xchgq	%rsi, %rdx
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	0x40(%rsp), %rax
               	movq	0x38(%rsp), %rdx
               	cmpq	$0x3f40, %rcx           # imm = 0x3F40
               	je	<addr>
               	movl	$0x1b, %eax
               	addq	$0x20, %rsp
               	addq	$0xc8, %rsp
               	retq
               	movq	%rax, %rdi
               	movq	%rdx, %rsi
               	callq	<addr>
               	movq	%rax, %rsi
               	movq	%rdx, %r8
               	movq	%rsi, 0xd0(%rsp)
               	movq	%r8, 0xd8(%rsp)
               	cmpq	$0xf, %rsi
               	jne	<addr>
               	cmpq	$-0x9, %r8
               	je	<addr>
               	movl	$0x1c, %eax
               	addq	$0x20, %rsp
               	addq	$0xc8, %rsp
               	retq
               	movl	$0x5, %eax
               	movl	$0xb, %ecx
               	movq	%rsi, 0x40(%rsp)
               	movq	%r8, 0x38(%rsp)
               	movq	%rcx, %rdi
               	movq	%rax, %rsi
               	callq	<addr>
               	movq	0x40(%rsp), %rsi
               	movq	0x38(%rsp), %r8
               	movq	%rax, 0x20(%rsp)
               	movq	%rdx, 0x28(%rsp)
               	movl	$0x3, %ecx
               	movq	%rsi, 0x40(%rsp)
               	movq	%r8, 0x38(%rsp)
               	movq	%rdx, 0x30(%rsp)
               	movq	%rax, %rdi
               	movq	%rdx, %rsi
               	movq	%rcx, %rdx
               	callq	<addr>
               	movq	0x40(%rsp), %rsi
               	movq	0x38(%rsp), %r8
               	movq	0x30(%rsp), %rdx
               	cmpq	$0xf, %rax
               	jne	<addr>
               	cmpq	$0x5, %rdx
               	je	<addr>
               	movl	$0x1d, %eax
               	addq	$0x20, %rsp
               	addq	$0xc8, %rsp
               	retq
               	movl	$0x1, %edi
               	movl	$0x3, %ecx
               	movq	%r8, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	cmpq	$-0x2303, %rax          # imm = 0xDCFD
               	je	<addr>
               	movl	$0x1e, %eax
               	addq	$0x20, %rsp
               	addq	$0xc8, %rsp
               	retq
               	movl	$0x4, %edi
               	movl	$0x9, %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, 0xd0(%rsp)
               	movq	%rdx, 0xd8(%rsp)
               	cmpq	$0x9, %rax
               	jne	<addr>
               	cmpq	$0x4, %rdx
               	je	<addr>
               	movl	$0x1f, %eax
               	addq	$0x20, %rsp
               	addq	$0xc8, %rsp
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	movq	%rax, 0xd0(%rsp)
               	movq	%rdx, 0xd8(%rsp)
               	cmpq	$0x7, %rax
               	jne	<addr>
               	cmpq	$0x8, %rdx
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x20, %eax
               	addq	$0x20, %rsp
               	addq	$0xc8, %rsp
               	retq
               	movl	$0x28, %eax
               	movl	$0x5, %ecx
               	movq	%rax, %rdi
               	movq	%rdx, %rsi
               	movq	%rcx, %rdx
               	callq	<addr>
               	movq	%rax, 0xd0(%rsp)
               	movq	%rdx, 0xd8(%rsp)
               	cmpq	$0x28, %rax
               	jne	<addr>
               	cmpq	$0x8, %rdx
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x21, %eax
               	addq	$0x20, %rsp
               	addq	$0xc8, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x20, %rsp
               	addq	$0xc8, %rsp
               	retq
