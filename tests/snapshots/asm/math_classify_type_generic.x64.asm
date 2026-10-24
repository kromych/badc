
math_classify_type_generic.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	movl	$0x800000, %eax         # imm = 0x800000
               	movl	$0x40000000, %ecx       # imm = 0x40000000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	vdivss	%xmm15, %xmm14, %xmm0
               	movss	%xmm0, -0x30(%rbp)
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x28(%rbp)
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	vdivsd	%xmm15, %xmm14, %xmm0
               	cvtsd2ss	%xmm0, %xmm1
               	movss	%xmm1, -0x20(%rbp)
               	movl	$0x80000000, -0x18(%rbp) # imm = 0x80000000
               	movabsq	$0x10000000000000, %rcx # imm = 0x10000000000000
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	movq	%rcx, %xmm14
               	movq	%rdx, %xmm15
               	vdivsd	%xmm15, %xmm14, %xmm1
               	movsd	%xmm1, -0x10(%rbp)
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rbp)
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x90(%rbp)
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x80(%rbp)
               	movabsq	$0x7fe1ccf385ebc8a0, %rcx # imm = 0x7FE1CCF385EBC8A0
               	movabsq	$0x4024000000000000, %rdx # imm = 0x4024000000000000
               	movq	%rcx, %xmm14
               	movq	%rdx, %xmm15
               	vmulsd	%xmm15, %xmm14, %xmm1
               	movsd	%xmm1, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x70(%rbp)
               	movsd	-0x8(%rbp), %xmm2
               	movsd	%xmm2, -0x40(%rbp)
               	movq	-0x40(%rbp), %rcx
               	movq	%rcx, %rdx
               	shrq	$0x34, %rdx
               	andq	$0x7ff, %rdx            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	testl	%edx, %edx
               	jne	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	cmpl	$0x7ff, %edx            # imm = 0x7FF
               	jne	<addr>
               	jmp	<addr>
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x40(%rbp)
               	movsd	-0x10(%rbp), %xmm2
               	movsd	%xmm2, -0x40(%rbp)
               	movq	-0x40(%rbp), %rax
               	movq	%rax, %rcx
               	shrq	$0x34, %rcx
               	andq	$0x7ff, %rcx            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movsd	%xmm1, -0x40(%rbp)
               	movq	-0x40(%rbp), %rax
               	movq	%rax, %rcx
               	shrq	$0x34, %rcx
               	andq	$0x7ff, %rcx            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movsd	%xmm0, -0x40(%rbp)
               	movq	-0x40(%rbp), %rax
               	movq	%rax, %rcx
               	shrq	$0x34, %rcx
               	andq	$0x7ff, %rcx            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	$0x3f800000, -0x38(%rbp) # imm = 0x3F800000
               	movl	-0x38(%rbp), %eax
               	movq	%rax, %rcx
               	shrq	$0x17, %rcx
               	andq	$0xff, %rcx
               	andq	$0x7fffff, %rax         # imm = 0x7FFFFF
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorq	$0xff, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	jmp	<addr>
               	movss	-0x28(%rbp), %xmm0
               	movss	%xmm0, -0x38(%rbp)
               	movl	-0x38(%rbp), %eax
               	movq	%rax, %rcx
               	shrq	$0x17, %rcx
               	andq	$0xff, %rcx
               	andq	$0x7fffff, %rax         # imm = 0x7FFFFF
               	testl	%ecx, %ecx
               	jne	<addr>
               	jmp	<addr>
               	xorq	$0xff, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	jmp	<addr>
               	movss	-0x30(%rbp), %xmm0
               	movss	%xmm0, -0x38(%rbp)
               	movl	-0x38(%rbp), %eax
               	movq	%rax, %rcx
               	shrq	$0x17, %rcx
               	andq	$0xff, %rcx
               	andq	$0x7fffff, %rax         # imm = 0x7FFFFF
               	testl	%ecx, %ecx
               	jne	<addr>
               	movss	-0x30(%rbp), %xmm0
               	movss	%xmm0, -0x38(%rbp)
               	movl	-0x38(%rbp), %eax
               	movq	%rax, %rcx
               	shrq	$0x17, %rcx
               	andq	$0xff, %rcx
               	andq	$0x7fffff, %rax         # imm = 0x7FFFFF
               	testl	%ecx, %ecx
               	jne	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movss	-0x30(%rbp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movsd	%xmm0, -0x40(%rbp)
               	movq	-0x40(%rbp), %rax
               	movq	%rax, %rcx
               	shrq	$0x34, %rcx
               	andq	$0x7ff, %rcx            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	cmpl	$0x7ff, %ecx            # imm = 0x7FF
               	jne	<addr>
               	jmp	<addr>
               	movsd	-0x10(%rbp), %xmm0
               	movsd	%xmm0, -0x40(%rbp)
               	movq	-0x40(%rbp), %rax
               	movq	%rax, %rcx
               	shrq	$0x34, %rcx
               	andq	$0x7ff, %rcx            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	testl	%ecx, %ecx
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movss	-0x18(%rbp), %xmm0
               	movss	%xmm0, -0x38(%rbp)
               	movl	-0x38(%rbp), %eax
               	movq	%rax, %rcx
               	shrq	$0x17, %rcx
               	andq	$0xff, %rcx
               	andq	$0x7fffff, %rax         # imm = 0x7FFFFF
               	testl	%ecx, %ecx
               	jne	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movss	-0x20(%rbp), %xmm0
               	movss	%xmm0, -0x38(%rbp)
               	movl	-0x38(%rbp), %eax
               	movq	%rax, %rcx
               	shrq	$0x17, %rcx
               	andq	$0xff, %rcx
               	andq	$0x7fffff, %rax         # imm = 0x7FFFFF
               	testl	%ecx, %ecx
               	jne	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	movss	-0x20(%rbp), %xmm0
               	movss	%xmm0, -0x38(%rbp)
               	movl	-0x38(%rbp), %eax
               	movq	%rax, %rcx
               	shrq	$0x17, %rcx
               	andq	$0xff, %rcx
               	andq	$0x7fffff, %rax         # imm = 0x7FFFFF
               	testl	%ecx, %ecx
               	jne	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movss	-0x20(%rbp), %xmm0
               	movss	%xmm0, -0x38(%rbp)
               	movl	-0x38(%rbp), %eax
               	movq	%rax, %rcx
               	shrq	$0x17, %rcx
               	andq	$0xff, %rcx
               	andq	$0x7fffff, %rax         # imm = 0x7FFFFF
               	testl	%ecx, %ecx
               	jne	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movss	-0x30(%rbp), %xmm0
               	movss	%xmm0, -0x38(%rbp)
               	movl	-0x38(%rbp), %eax
               	movq	%rax, %rcx
               	shrq	$0x17, %rcx
               	andq	$0xff, %rcx
               	andq	$0x7fffff, %rax         # imm = 0x7FFFFF
               	testl	%ecx, %ecx
               	jne	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movss	-0x18(%rbp), %xmm0
               	movss	%xmm0, -0x38(%rbp)
               	movl	-0x38(%rbp), %eax
               	shrq	$0x1f, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movss	-0x28(%rbp), %xmm0
               	movss	%xmm0, -0x38(%rbp)
               	movl	-0x38(%rbp), %eax
               	shrq	$0x1f, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movss	-0x30(%rbp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, -0x38(%rbp)
               	movl	-0x38(%rbp), %eax
               	shrq	$0x1f, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movabsq	$-0x4010000000000000, %rax # imm = 0xBFF0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x40(%rbp)
               	movq	-0x40(%rbp), %rax
               	shrq	$0x3f, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	fldt	-0x90(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	-0x60(%rbp), %rax
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x60(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	fldt	-0x50(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x40(%rbp)
               	movq	-0x40(%rbp), %rax
               	movq	%rax, %rdx
               	shrq	$0x34, %rdx
               	andq	$0x7ff, %rdx            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	testl	%edx, %edx
               	jne	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	cmpl	$0x7ff, %edx            # imm = 0x7FF
               	jne	<addr>
               	jmp	<addr>
               	fldt	-0x80(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	-0x60(%rbp), %rax
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x60(%rbp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	fldt	-0x50(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x40(%rbp)
               	movq	-0x40(%rbp), %rax
               	movq	%rax, %rdx
               	shrq	$0x34, %rdx
               	andq	$0x7ff, %rdx            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	testl	%edx, %edx
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	fldt	-0x70(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	-0x60(%rbp), %rax
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x60(%rbp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	fldt	-0x50(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x40(%rbp)
               	movq	-0x40(%rbp), %rax
               	movq	%rax, %rcx
               	shrq	$0x34, %rcx
               	andq	$0x7ff, %rcx            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	testl	%ecx, %ecx
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	fldt	-0x90(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	-0x60(%rbp), %rax
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x60(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	fldt	-0x50(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x40(%rbp)
               	movq	-0x40(%rbp), %rax
               	shrq	$0x3f, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movss	-0x20(%rbp), %xmm0
               	movss	%xmm0, -0x38(%rbp)
               	movl	-0x38(%rbp), %eax
               	movq	%rax, %rcx
               	shrq	$0x17, %rcx
               	andq	$0xff, %rcx
               	andq	$0x7fffff, %rax         # imm = 0x7FFFFF
               	testl	%ecx, %ecx
               	jne	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	movss	-0x20(%rbp), %xmm0
               	movss	%xmm0, -0x38(%rbp)
               	movl	-0x38(%rbp), %eax
               	movq	%rax, %rcx
               	shrq	$0x17, %rcx
               	andq	$0xff, %rcx
               	andq	$0x7fffff, %rax         # imm = 0x7FFFFF
               	testl	%ecx, %ecx
               	jne	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3f800000, -0x38(%rbp) # imm = 0x3F800000
               	movl	-0x38(%rbp), %eax
               	movq	%rax, %rcx
               	shrq	$0x17, %rcx
               	andq	$0xff, %rcx
               	andq	$0x7fffff, %rax         # imm = 0x7FFFFF
               	testl	%ecx, %ecx
               	jne	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	movsd	-0x8(%rbp), %xmm0
               	movsd	%xmm0, -0x40(%rbp)
               	movq	-0x40(%rbp), %rax
               	movq	%rax, %rcx
               	shrq	$0x34, %rcx
               	andq	$0x7ff, %rcx            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	testl	%ecx, %ecx
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	testl	%eax, %eax
               	je	<addr>
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x40(%rbp)
               	movq	-0x40(%rbp), %rax
               	movq	%rax, %rcx
               	shrq	$0x34, %rcx
               	andq	$0x7ff, %rcx            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	testl	%ecx, %ecx
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpl	$0x7ff, %ecx            # imm = 0x7FF
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpl	$0x7ff, %ecx            # imm = 0x7FF
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	xorq	$0xff, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	xorq	$0xff, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movl	$0x3, %eax
               	jmp	<addr>
               	xorq	$0xff, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpl	$0x7ff, %ecx            # imm = 0x7FF
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpl	$0x7ff, %edx            # imm = 0x7FF
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	xorq	$0xff, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	xorq	$0xff, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	xorq	$0xff, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	xorq	$0xff, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	xorq	$0xff, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpl	$0x7ff, %ecx            # imm = 0x7FF
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	xorq	$0xff, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorq	$0xff, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	jmp	<addr>
               	cmpl	$0x7ff, %ecx            # imm = 0x7FF
               	jne	<addr>
               	jmp	<addr>
               	cmpl	$0x7ff, %ecx            # imm = 0x7FF
               	jne	<addr>
               	jmp	<addr>
               	cmpl	$0x7ff, %ecx            # imm = 0x7FF
               	jne	<addr>
               	jmp	<addr>
