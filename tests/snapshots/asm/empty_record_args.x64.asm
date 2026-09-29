
empty_record_args.x64:	file format elf64-x86-64

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

<mk>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x7, (%rsi)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	leave
               	retq

<first>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x2a, %eax
               	leave
               	retq

<mid>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	cvttsd2si	%xmm0, %rax
               	imulq	$0xa, %rax, %rax
               	addq	$0x4b0, %rax            # imm = 0x4B0
               	addq	$0x4, %rax
               	leave
               	retq

<last>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0xb, %eax
               	leave
               	retq

<fp>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	cvtss2sd	%xmm1, %xmm1
               	addsd	%xmm1, %xmm0
               	addsd	%xmm2, %xmm0
               	leave
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
               	movslq	(%rax), %rax
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
               	movslq	(%rcx), %rcx
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
               	movslq	-0xd0(%rbp), %rdx
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	$0x0, -0x10(%rbp)
               	movl	$0x7, %edi
               	leaq	-0x10(%rbp), %rsi
               	callq	<addr>
               	movslq	-0x10(%rbp), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x28(%rbp), %r9
               	movl	$0x2a, %edi
               	callq	<addr>
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x1, %edi
               	leaq	-0x20(%rbp), %r9
               	movl	$0x2, %esi
               	leaq	-0x8(%rbp), %rax
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	leaq	-0x18(%rbp), %r8
               	movl	$0x4, %edx
               	movq	%rcx, %xmm0
               	callq	<addr>
               	cmpl	$0x4d2, %eax            # imm = 0x4D2
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x5, %edi
               	movl	$0x6, %esi
               	leaq	-0x8(%rbp), %r9
               	callq	<addr>
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	leaq	-0x28(%rbp), %r9
               	movl	$0x40100000, %ecx       # imm = 0x40100000
               	leaq	-0x18(%rbp), %rdx
               	movabsq	$0x4010000000000000, %rsi # imm = 0x4010000000000000
               	movq	%rax, %xmm0
               	movq	%rcx, %xmm1
               	movq	%rsi, %xmm2
               	callq	<addr>
               	movabsq	$0x401f000000000000, %rax # imm = 0x401F000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	leaq	-0x28(%rbp), %r9
               	movl	$0x3, %edx
               	leaq	-0x8(%rbp), %rax
               	movabsq	$0x4010000000000000, %rcx # imm = 0x4010000000000000
               	movq	%rcx, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	cmpl	$0x10e1, %eax           # imm = 0x10E1
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
