
aggregate_register_parts.x64:	file format elf64-x86-64

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

<by_value>:
               	movq	%rsi, %rdx
               	leaq	0x1(%rdi), %rax
               	retq

<make_pair>:
               	movq	%rdi, %rax
               	movq	%rsi, %rdx
               	retq

<swapq>:
               	movq	%rdi, %rax
               	shrq	$0x20, %rax
               	movl	%edi, %ecx
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	retq

<tail>:
               	movslq	%esi, %rax
               	addq	%rdi, %rax
               	movq	%rsi, %rcx
               	shlq	%rcx
               	movl	%ecx, %edx
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
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	shlq	$0x10, %rcx
               	orq	%rcx, %rax
               	movl	%r8d, %ecx
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	retq

<dsum>:
               	vaddsd	%xmm1, %xmm0, %xmm2
               	vsubsd	%xmm1, %xmm0, %xmm1
               	movapd	%xmm2, %xmm0
               	retq

<rot3>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movsd	%xmm0, -0x10(%rbp)
               	movsd	%xmm1, -0x8(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movss	-0xc(%rbp), %xmm0
               	movss	%xmm0, -0x20(%rbp)
               	movss	-0x8(%rbp), %xmm0
               	movss	%xmm0, -0x1c(%rbp)
               	movss	-0x10(%rbp), %xmm0
               	movss	%xmm0, -0x18(%rbp)
               	movq	%rax, %rcx
               	movsd	(%rcx), %xmm0
               	movss	0x8(%rcx), %xmm1
               	leave
               	retq

<twice>:
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	retq

<dl>:
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	leaq	0x1(%rdi), %rax
               	retq

<fi>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movss	-0x8(%rbp), %xmm0
               	movl	$0x3f800000, %ecx       # imm = 0x3F800000
               	movq	%rcx, %xmm15
               	addss	%xmm15, %xmm0
               	movss	%xmm0, -0x8(%rbp)
               	movl	-0x4(%rbp), %ecx
               	incq	%rcx
               	movl	%ecx, -0x4(%rbp)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	leave
               	retq

<ubump>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	-0x8(%rbp), %rcx
               	incq	%rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	leave
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
               	movq	%rdi, %rax
               	shrq	$0x20, %rax
               	movslq	%edi, %rcx
               	leaq	(%rsi,%rcx), %rdx
               	movl	%edi, %ecx
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	retq

<pp>:
               	leaq	0x4(%rdi), %rax
               	leaq	-0x1(%rsi), %rdx
               	retq

<big>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	leaq	-0x18(%rbp), %rcx
               	movq	-0x8(%rbp), %rax
               	movq	-0x18(%rbp), %rdx
               	movq	-0x10(%rbp), %rsi
               	addq	%rsi, %rdx
               	addq	%rdx, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x30(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	leave
               	retq

<sum_via_ptr>:
               	movq	(%rdi), %rax
               	movq	0x8(%rdi), %rcx
               	addq	%rcx, %rax
               	retq

<bump_via_ptr>:
               	movq	(%rdi), %rax
               	addq	$0xa, %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rdi), %rax
               	addq	$0x14, %rax
               	movq	%rax, 0x8(%rdi)
               	retq

<escape>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	movq	%rsi, -0x8(%rbp)
               	callq	<addr>
               	leave
               	retq

<escape_ret>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	movq	%rsi, -0x8(%rbp)
               	callq	<addr>
               	movq	-0x10(%rbp), %rax
               	movq	-0x8(%rbp), %rdx
               	leave
               	retq

<forward>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	movq	%rsi, -0x8(%rbp)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	leave
               	retq

<pick>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rdi, %rax
               	movq	%rsi, %rdx
               	popq	%rbp
               	retq
               	xchgq	%rsi, %rdi
               	callq	<addr>
               	popq	%rbp
               	retq

<live>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movq	%rdi, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	movq	%rsi, -0x8(%rbp)
               	leaq	(%rdx,%rdx,2), %rbx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	addq	%rbx, %rax
               	addq	%rdx, %rax
               	popq	%rbx
               	leave
               	retq

<ret_global>:
               	leaq	<rip>, %rcx      # <addr>
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	retq

<lit>:
               	movq	%rdi, %rax
               	leaq	0x1(%rax), %rdx
               	retq

<rec>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edx, %rdx
               	movq	%rdi, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	movq	%rsi, -0x8(%rbp)
               	testl	%edx, %edx
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, %rdx
               	leave
               	retq
               	movq	-0x10(%rbp), %rax
               	addq	%rdx, %rax
               	movq	%rax, -0x10(%rbp)
               	decq	%rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	leave
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	%rdx, %rbx
               	imulq	%rcx, %rbx
               	movq	%r8, %r12
               	imulq	%r9, %r12
               	movq	0x10(%rbp), %rax
               	movq	0x18(%rbp), %rsi
               	movq	%rax, %r13
               	imulq	%rsi, %r13
               	addq	%r8, %rdx
               	leaq	(%rdx,%rax), %r14
               	leaq	(%rcx,%r9), %rax
               	leaq	(%rax,%rsi), %r15
               	movq	%rbx, %r10
               	xorq	%r12, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%r13, %r10
               	xorq	%r14, %r10
               	movq	%r10, 0x40(%rsp)
               	imulq	$0x7, %r15, %r10
               	movq	%r10, 0x38(%rsp)
               	leaq	-0x10(%rbp), %rdi
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	leaq	(%rbx,%r12), %rcx
               	addq	%r13, %rcx
               	addq	%r14, %rcx
               	addq	%r15, %rcx
               	addq	0x48(%rsp), %rcx
               	addq	0x40(%rsp), %rcx
               	addq	0x38(%rsp), %rcx
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
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
               	leaq	<rip>, %rax      # <addr>
               	movq	%rdi, (%rax)
               	leaq	0x1(%rdi), %rax
               	retq

<const_across>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movl	$0x7, %eax
               	movl	$0x8, %edx
               	popq	%rbp
               	retq

<keep_across>:
               	pushq	%rbp
               	movq	%rsp, %rbp
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
               	popq	%rbp
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x130, %rsp            # imm = 0x130
               	leaq	-0xd0(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	-0x110(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0xc0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x108(%rbp), %rax
               	leaq	<rip>, %rcx
               	movzwq	(%rcx), %r10
               	movw	%r10w, (%rax)
               	movzbq	0x2(%rcx), %r10
               	movb	%r10b, 0x2(%rax)
               	leaq	-0xb0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xa0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x90(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movl	0x8(%rcx), %r10d
               	movl	%r10d, 0x8(%rax)
               	leaq	-0x100(%rbp), %rax
               	leaq	<rip>, %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	leaq	-0x80(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xf8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0xf0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movzbq	(%rcx), %r10
               	movb	%r10b, (%rax)
               	leaq	-0xe8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movzwq	(%rcx), %r10
               	movw	%r10w, (%rax)
               	leaq	-0xe0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	leaq	-0xd8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x70(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x60(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x50(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%rax, -0x50(%rbp)
               	movq	$0x4, -0x48(%rbp)
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x40(%rbp)
               	leaq	-0x40(%rbp), %rax
               	movq	%rdx, -0x38(%rbp)
               	leaq	-0xd0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movq	-0xd0(%rbp), %rax
               	cmpq	$0x8, %rax
               	jne	<addr>
               	movq	-0xc8(%rbp), %rax
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x15, %edi
               	movl	$0x16, %esi
               	callq	<addr>
               	movq	%rax, -0x40(%rbp)
               	leaq	-0x40(%rbp), %rax
               	movq	%rdx, -0x38(%rbp)
               	leaq	-0xd0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movq	-0xd0(%rbp), %rax
               	cmpq	$0x15, %rax
               	jne	<addr>
               	movq	-0xc8(%rbp), %rax
               	cmpq	$0x16, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x110(%rbp), %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x38(%rbp)
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x110(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movl	-0x110(%rbp), %eax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movl	-0x10c(%rbp), %eax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0xc0(%rbp), %rdi
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x40(%rbp)
               	leaq	-0x40(%rbp), %rax
               	movq	%rdx, -0x38(%rbp)
               	leaq	-0xc0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movq	-0xc0(%rbp), %rax
               	cmpq	$0xb, %rax
               	jne	<addr>
               	movl	-0xb8(%rbp), %eax
               	cmpl	$0xc, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-0x108(%rbp), %rdi
               	movzwq	(%rdi), %r10
               	movzbq	0x2(%rdi), %r11
               	shlq	$0x10, %r11
               	orq	%r11, %r10
               	movq	%r10, %rdi
               	callq	<addr>
               	movw	%ax, -0x38(%rbp)
               	shrq	$0x10, %rax
               	leaq	-0x38(%rbp), %rcx
               	movb	%al, -0x36(%rbp)
               	leaq	-0x108(%rbp), %rax
               	movzwq	(%rcx), %r10
               	movw	%r10w, (%rax)
               	movzbq	0x2(%rcx), %r10
               	movb	%r10b, 0x2(%rax)
               	movsbq	-0x108(%rbp), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movsbq	-0x107(%rbp), %rax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movsbq	-0x106(%rbp), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	-0xb0(%rbp), %rdi
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x40(%rbp)
               	leaq	-0x40(%rbp), %rax
               	movq	%rdx, -0x38(%rbp)
               	leaq	-0xb0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsbq	-0xb0(%rbp), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movswq	-0xae(%rbp), %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movl	-0xac(%rbp), %eax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movq	-0xa8(%rbp), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	-0xa0(%rbp), %r9
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	movsd	0x8(%r10), %xmm1
               	callq	<addr>
               	movsd	%xmm0, -0x40(%rbp)
               	leaq	-0x40(%rbp), %rax
               	movsd	%xmm1, -0x38(%rbp)
               	leaq	-0xa0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	-0xa0(%rbp), %xmm0
               	movabsq	$0x3ffc000000000000, %rax # imm = 0x3FFC000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	-0x98(%rbp), %xmm0
               	movabsq	$0x3ff4000000000000, %rax # imm = 0x3FF4000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0x90(%rbp), %r9
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	movss	0x8(%r10), %xmm1
               	callq	<addr>
               	movsd	%xmm0, -0x40(%rbp)
               	movss	%xmm1, -0x38(%rbp)
               	leaq	-0x40(%rbp), %rax
               	leaq	-0x90(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movl	0x8(%rax), %r10d
               	movl	%r10d, 0x8(%rcx)
               	movss	-0x90(%rbp), %xmm0
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x8c(%rbp), %xmm0
               	movl	$0x40400000, %eax       # imm = 0x40400000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x88(%rbp), %xmm0
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	-0x100(%rbp), %r9
               	movq	%r9, %r10
               	movss	(%r10), %xmm0
               	callq	<addr>
               	movss	%xmm0, -0x38(%rbp)
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x100(%rbp), %rcx
               	movl	(%rax), %r10d
               	movl	%r10d, (%rcx)
               	movss	-0x100(%rbp), %xmm0
               	movl	$0x40400000, %eax       # imm = 0x40400000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	-0x80(%rbp), %rdi
               	movsd	(%rdi), %xmm0
               	movq	0x8(%rdi), %rdi
               	callq	<addr>
               	movsd	%xmm0, -0x40(%rbp)
               	leaq	-0x40(%rbp), %rcx
               	movq	%rax, -0x38(%rbp)
               	leaq	-0x80(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movsd	-0x80(%rbp), %xmm0
               	movabsq	$0x4014000000000000, %rax # imm = 0x4014000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	-0x78(%rbp), %rax
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	leaq	-0xf8(%rbp), %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x38(%rbp)
               	leaq	-0x38(%rbp), %rax
               	leaq	-0xf8(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movss	-0xf8(%rbp), %xmm0
               	movl	$0x3fc00000, %eax       # imm = 0x3FC00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	-0xf4(%rbp), %eax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	leaq	-0x78(%rbp), %rdi
               	movq	$0x29, -0x78(%rbp)
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x38(%rbp)
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x78(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movq	-0x78(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	leaq	-0xf0(%rbp), %rdi
               	movzbq	(%rdi), %rdi
               	callq	<addr>
               	movb	%al, -0x38(%rbp)
               	leaq	-0x38(%rbp), %rax
               	leaq	-0xf0(%rbp), %rcx
               	movzbq	(%rax), %r10
               	movb	%r10b, (%rcx)
               	leaq	-0xe8(%rbp), %rdi
               	movzwq	(%rdi), %rdi
               	callq	<addr>
               	movw	%ax, -0x38(%rbp)
               	leaq	-0x38(%rbp), %rax
               	leaq	-0xe8(%rbp), %rcx
               	movzwq	(%rax), %r10
               	movw	%r10w, (%rcx)
               	leaq	-0xe0(%rbp), %rdi
               	movl	(%rdi), %edi
               	callq	<addr>
               	movl	%eax, -0x38(%rbp)
               	leaq	-0x38(%rbp), %rax
               	leaq	-0xe0(%rbp), %rcx
               	movl	(%rax), %r10d
               	movl	%r10d, (%rcx)
               	leaq	-0xd8(%rbp), %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x38(%rbp)
               	leaq	-0x38(%rbp), %rax
               	leaq	-0xd8(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movsbq	-0xf0(%rbp), %rax
               	cmpl	$0x6, %eax
               	jne	<addr>
               	movswq	-0xe8(%rbp), %rax
               	cmpl	$0x259, %eax            # imm = 0x259
               	jne	<addr>
               	movl	-0xe0(%rbp), %eax
               	cmpl	$0x11171, %eax          # imm = 0x11171
               	jne	<addr>
               	movq	-0xd8(%rbp), %rax
               	movabsq	$0x1dcd65001, %r11      # imm = 0x1DCD65001
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	leaq	-0x70(%rbp), %rdi
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x40(%rbp)
               	leaq	-0x40(%rbp), %rax
               	movq	%rdx, -0x38(%rbp)
               	leaq	-0x70(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movl	-0x70(%rbp), %eax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movl	-0x6c(%rbp), %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movq	-0x68(%rbp), %rax
               	cmpq	$0x1f, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %rdi
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x40(%rbp)
               	leaq	-0x40(%rbp), %rax
               	movq	%rdx, -0x38(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movq	-0x50(%rbp), %rax
               	leaq	-0x60(%rbp), %rcx
               	addq	$0x4, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	-0x48(%rbp), %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movq	-0x50(%rbp), %rax
               	movl	(%rax), %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	leaq	-0x30(%rbp), %r9
               	leaq	-0x18(%rbp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	-0x18(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movq	0x10(%rax), %r10
               	movq	%r10, 0x10(%rcx)
               	movq	-0x30(%rbp), %rax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movq	-0x28(%rbp), %rax
               	cmpq	$0x2, %rax
               	jne	<addr>
               	movq	-0x20(%rbp), %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	leaq	-0xd0(%rbp), %rdi
               	movq	$0x7, -0xd0(%rbp)
               	movq	$0xb, -0xc8(%rbp)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	cmpq	$0x12, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	leaq	-0xd0(%rbp), %rdi
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	movq	%rdx, -0x20(%rbp)
               	leaq	-0xd0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xd0(%rbp), %rdi
               	movq	-0xd0(%rbp), %rax
               	cmpq	$0x11, %rax
               	jne	<addr>
               	movq	-0xc8(%rbp), %rax
               	cmpq	$0x1f, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	movq	%rdx, -0x20(%rbp)
               	leaq	-0xd0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xd0(%rbp), %rdi
               	movq	-0xd0(%rbp), %rax
               	cmpq	$0x12, %rax
               	jne	<addr>
               	movq	-0xc8(%rbp), %rax
               	cmpq	$0x1f, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	movl	$0x1, %edx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	movq	%rdx, -0x20(%rbp)
               	leaq	-0xd0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xd0(%rbp), %rdi
               	movq	-0xd0(%rbp), %rax
               	cmpq	$0x12, %rax
               	jne	<addr>
               	movq	-0xc8(%rbp), %rax
               	cmpq	$0x1f, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	xorl	%edx, %edx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	movq	%rdx, -0x20(%rbp)
               	leaq	-0xd0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xd0(%rbp), %rdi
               	movq	-0xd0(%rbp), %rax
               	cmpq	$0x1f, %rax
               	jne	<addr>
               	movq	-0xc8(%rbp), %rax
               	cmpq	$0x12, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	movl	$0x2, %edx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	cmpq	$0x38, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	movq	%rdx, -0x20(%rbp)
               	leaq	-0xd0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movq	-0xd0(%rbp), %rax
               	cmpq	$0x64, %rax
               	jne	<addr>
               	movq	-0xc8(%rbp), %rax
               	cmpq	$0xc8, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	movl	$0x5, %edi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	movq	%rdx, -0x20(%rbp)
               	leaq	-0xd0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xd0(%rbp), %rdi
               	movq	-0xd0(%rbp), %rax
               	cmpq	$0x5, %rax
               	jne	<addr>
               	movq	-0xc8(%rbp), %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	leave
               	retq
               	movl	$0x4, %edx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	movq	%rdx, -0x20(%rbp)
               	leaq	-0xd0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xd0(%rbp), %rdi
               	movq	-0xd0(%rbp), %rax
               	cmpq	$0xf, %rax
               	jne	<addr>
               	movq	-0xc8(%rbp), %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x19, %eax
               	leave
               	retq
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	cmpq	$0x60, %rax
               	je	<addr>
               	movl	$0x1a, %eax
               	leave
               	retq
               	leaq	-0xd0(%rbp), %rdi
               	movl	$0x1, %edx
               	movl	$0x2, %ecx
               	movl	$0x3, %r8d
               	movl	$0x4, %r9d
               	movl	$0x5, %eax
               	movl	$0x6, %esi
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rsi, 0x8(%rsp)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	addq	$0x10, %rsp
               	cmpq	$0x3f40, %rax           # imm = 0x3F40
               	je	<addr>
               	movl	$0x1b, %eax
               	leave
               	retq
               	leaq	-0xd0(%rbp), %rdi
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	movq	%rdx, -0x20(%rbp)
               	leaq	-0xd0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movq	-0xd0(%rbp), %rax
               	cmpq	$0xf, %rax
               	jne	<addr>
               	movq	-0xc8(%rbp), %rax
               	cmpq	$-0x9, %rax
               	je	<addr>
               	movl	$0x1c, %eax
               	leave
               	retq
               	leaq	-0x130(%rbp), %rdi
               	movq	$0xb, -0x130(%rbp)
               	movq	$0x5, -0x128(%rbp)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x120(%rbp)
               	leaq	-0x120(%rbp), %rax
               	movq	%rdx, -0x118(%rbp)
               	leaq	-0x130(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x130(%rbp), %rdi
               	movl	$0x3, %edx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	cmpq	$0xf, %rax
               	jne	<addr>
               	movq	-0x128(%rbp), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x1d, %eax
               	leave
               	retq
               	movl	$0x1, %edi
               	leaq	-0xd0(%rbp), %rsi
               	movl	$0x3, %ecx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	cmpq	$-0x2303, %rax          # imm = 0xDCFD
               	je	<addr>
               	movl	$0x1e, %eax
               	leave
               	retq
               	movl	$0x4, %edi
               	movl	$0x9, %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	movq	%rdx, -0x20(%rbp)
               	leaq	-0xd0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movq	-0xd0(%rbp), %rax
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	-0xc8(%rbp), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x1f, %eax
               	leave
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	movq	%rdx, -0x20(%rbp)
               	leaq	-0xd0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xd0(%rbp), %rdi
               	movq	-0xd0(%rbp), %rax
               	cmpq	$0x7, %rax
               	jne	<addr>
               	movq	-0xc8(%rbp), %rax
               	cmpq	$0x8, %rax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x20, %eax
               	leave
               	retq
               	movq	$0x28, -0xd0(%rbp)
               	movl	$0x5, %edx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	movq	%rdx, -0x20(%rbp)
               	leaq	-0xd0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movq	-0xd0(%rbp), %rax
               	cmpq	$0x28, %rax
               	jne	<addr>
               	movq	-0xc8(%rbp), %rax
               	cmpq	$0x8, %rax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x21, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
