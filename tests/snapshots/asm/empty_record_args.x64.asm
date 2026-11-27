
empty_record_args.x64:	file format elf64-x86-64

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

<mk>:
               	subq	$0x18, %rsp
               	movl	$0x7, (%rsi)
               	leaq	0x8(%rsp), %rax
               	movq	%rax, %rcx
               	addq	$0x18, %rsp
               	retq

<first>:
               	subq	$0x18, %rsp
               	movl	$0x2a, %eax
               	addq	$0x18, %rsp
               	retq

<mid>:
               	subq	$0x28, %rsp
               	cvttsd2si	%xmm0, %rax
               	imulq	$0xa, %rax, %rax
               	addq	$0x4b0, %rax            # imm = 0x4B0
               	addq	$0x4, %rax
               	addq	$0x28, %rsp
               	retq

<last>:
               	subq	$0x18, %rsp
               	movl	$0xb, %eax
               	addq	$0x18, %rsp
               	retq

<fp>:
               	subq	$0x28, %rsp
               	cvtss2sd	%xmm1, %xmm1
               	addsd	%xmm1, %xmm0
               	addsd	%xmm2, %xmm0
               	addq	$0x28, %rsp
               	retq

<var>:
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
               	movl	(%rax), %eax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rcx, %r11
               	movq	%r11, %rcx
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
               	movl	(%rcx), %ecx
               	leaq	-0x18(%rbp), %rdx
               	movq	%rdx, %r11
               	movq	%r11, %rdx
               	leaq	-0x18(%rbp), %rdx
               	movq	%rdx, %r11
               	movl	0x4(%r11), %r10d
               	cmpq	$0xb0, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x10, 0x4(%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rdx
               	movsd	(%rdx), %xmm0
               	leaq	-0x18(%rbp), %rdx
               	movl	-0xd0(%rbp), %edx
               	imulq	$0xa, %rax, %rax
               	addq	%rdx, %rax
               	imulq	$0x64, %rcx, %rcx
               	addq	%rcx, %rax
               	cvttsd2si	%xmm0, %rcx
               	imulq	$0x3e8, %rcx, %rcx      # imm = 0x3E8
               	addq	%rcx, %rax
               	leave
               	retq

<main>:
               	subq	$0x38, %rsp
               	movl	$0x0, 0x20(%rsp)
               	movl	$0x7, %edi
               	leaq	0x20(%rsp), %rsi
               	callq	<addr>
               	movl	0x20(%rsp), %eax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x38, %rsp
               	retq
               	leaq	0x8(%rsp), %r9
               	movl	$0x2a, %edi
               	callq	<addr>
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x38, %rsp
               	retq
               	leaq	0x10(%rsp), %r9
               	leaq	0x28(%rsp), %rax
               	movsd	<rip>, %xmm0
               	leaq	0x18(%rsp), %rcx
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x4, %edx
               	callq	<addr>
               	cmpl	$0x4d2, %eax            # imm = 0x4D2
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x38, %rsp
               	retq
               	leaq	0x28(%rsp), %r9
               	movl	$0x5, %edi
               	movl	$0x6, %esi
               	callq	<addr>
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x38, %rsp
               	retq
               	movsd	<rip>, %xmm0
               	leaq	0x8(%rsp), %r9
               	movss	<rip>, %xmm1
               	leaq	0x18(%rsp), %rax
               	movsd	<rip>, %xmm2
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x38, %rsp
               	retq
               	leaq	0x8(%rsp), %r9
               	leaq	0x28(%rsp), %rax
               	movsd	<rip>, %xmm0
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	movb	$0x1, %al
               	callq	<addr>
               	cmpl	$0x10e1, %eax           # imm = 0x10E1
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x38, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x38, %rsp
               	retq
