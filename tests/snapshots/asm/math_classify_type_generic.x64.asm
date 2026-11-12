
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
               	movl	$0x400000, -0x30(%rbp)  # imm = 0x400000
               	movl	$0x800000, -0x28(%rbp)  # imm = 0x800000
               	movl	$0x7fc00000, -0x20(%rbp) # imm = 0x7FC00000
               	movl	$0x80000000, -0x18(%rbp) # imm = 0x80000000
               	movabsq	$0x8000000000000, %rcx  # imm = 0x8000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x10(%rbp)
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rbp)
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x90(%rbp)
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x80(%rbp)
               	movabsq	$0x7ff0000000000000, %rdx # imm = 0x7FF0000000000000
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x70(%rbp)
               	movsd	-0x8(%rbp), %xmm0
               	movq	%xmm0, %rdx
               	shrq	$0x34, %rdx
               	andq	$0x7ff, %rdx            # imm = 0x7FF
               	testl	%edx, %edx
               	jne	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	cmpl	$0x7ff, %edx            # imm = 0x7FF
               	je	<addr>
               	movsd	-0x10(%rbp), %xmm0
               	movq	%xmm0, %rdx
               	shrq	$0x34, %rdx
               	andq	$0x7ff, %rdx            # imm = 0x7FF
               	testl	%edx, %edx
               	jne	<addr>
               	movl	$0x7f800000, -0x38(%rbp) # imm = 0x7F800000
               	movl	-0x38(%rbp), %edx
               	shrq	$0x17, %rdx
               	andq	$0xff, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movl	$0x7fc00000, -0x38(%rbp) # imm = 0x7FC00000
               	movl	-0x38(%rbp), %eax
               	shrq	$0x17, %rax
               	andq	$0xff, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3f800000, -0x38(%rbp) # imm = 0x3F800000
               	movl	-0x38(%rbp), %eax
               	shrq	$0x17, %rax
               	andq	$0xff, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	cmpl	$0xff, %eax
               	je	<addr>
               	movss	-0x28(%rbp), %xmm0
               	movss	%xmm0, -0x38(%rbp)
               	movl	-0x38(%rbp), %eax
               	shrq	$0x17, %rax
               	andq	$0xff, %rax
               	testl	%eax, %eax
               	je	<addr>
               	cmpl	$0xff, %eax
               	je	<addr>
               	movss	-0x30(%rbp), %xmm0
               	movss	%xmm0, -0x38(%rbp)
               	movl	-0x38(%rbp), %eax
               	shrq	$0x17, %rax
               	andq	$0xff, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movss	-0x30(%rbp), %xmm0
               	movss	%xmm0, -0x38(%rbp)
               	movl	-0x38(%rbp), %eax
               	movq	%rax, %rdx
               	shrq	$0x17, %rdx
               	andq	$0xff, %rdx
               	andq	$0x7fffff, %rax         # imm = 0x7FFFFF
               	testl	%edx, %edx
               	jne	<addr>
               	movl	$0x2, %ecx
               	movl	$0x3, %edx
               	testl	%eax, %eax
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movss	-0x30(%rbp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%xmm0, %rax
               	shrq	$0x34, %rax
               	andq	$0x7ff, %rax            # imm = 0x7FF
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	cmpl	$0x7ff, %eax            # imm = 0x7FF
               	je	<addr>
               	movsd	-0x10(%rbp), %xmm0
               	movq	%xmm0, %rax
               	movq	%rax, %rcx
               	shrq	$0x34, %rcx
               	andq	$0x7ff, %rcx            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	$0x2, %ecx
               	movl	$0x3, %edx
               	testq	%rax, %rax
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
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
               	movl	$0x2, %ecx
               	movl	$0x3, %edx
               	testl	%eax, %eax
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
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
               	movl	$0x2, %ecx
               	movl	$0x3, %edx
               	testl	%eax, %eax
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
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
               	movl	$0x2, %ecx
               	movl	$0x3, %edx
               	testl	%eax, %eax
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
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
               	movl	$0x2, %ecx
               	movl	$0x3, %edx
               	testl	%eax, %eax
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
               	testl	%eax, %eax
               	je	<addr>
               	cmpl	$0x1, %eax
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
               	movl	$0x2, %ecx
               	movl	$0x3, %edx
               	testl	%eax, %eax
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
               	testl	%eax, %eax
               	je	<addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
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
               	fldt	-0x90(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	-0x60(%rbp), %rcx
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x60(%rbp)
               	leaq	-0x50(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	fldt	-0x60(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movq	%xmm0, %rcx
               	shrq	$0x34, %rcx
               	andq	$0x7ff, %rcx            # imm = 0x7FF
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	cmpl	$0x7ff, %ecx            # imm = 0x7FF
               	je	<addr>
               	fldt	-0x80(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	-0x60(%rbp), %rcx
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x60(%rbp)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	fldt	-0x60(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movq	%xmm0, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x34, %rdx
               	andq	$0x7ff, %rdx            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	testl	%edx, %edx
               	jne	<addr>
               	movl	$0x2, %edx
               	movl	$0x3, %esi
               	testq	%rcx, %rcx
               	movq	%rdx, %rcx
               	cmovneq	%rsi, %rcx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	fldt	-0x70(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	leaq	-0x60(%rbp), %rcx
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x60(%rbp)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	fldt	-0x60(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movq	%xmm0, %rax
               	movq	%rax, %rcx
               	shrq	$0x34, %rcx
               	andq	$0x7ff, %rcx            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	$0x2, %ecx
               	movl	$0x3, %edx
               	testq	%rax, %rax
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
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
               	fldt	-0x60(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movq	%xmm0, %rax
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
               	movl	$0x2, %ecx
               	movl	$0x3, %edx
               	testl	%eax, %eax
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movss	-0x20(%rbp), %xmm0
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jnp	<addr>
               	movsd	-0x8(%rbp), %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jnp	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x8, %eax
               	leave
               	retq
               	cmpl	$0xff, %ecx
               	jne	<addr>
               	movl	$0x1, %ecx
               	xorl	%edx, %edx
               	testl	%eax, %eax
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
               	jmp	<addr>
               	cmpl	$0x7ff, %ecx            # imm = 0x7FF
               	jne	<addr>
               	movl	$0x1, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
               	jmp	<addr>
               	cmpl	$0x7ff, %edx            # imm = 0x7FF
               	jne	<addr>
               	movl	$0x1, %edx
               	xorl	%esi, %esi
               	testq	%rcx, %rcx
               	movq	%rdx, %rcx
               	cmovneq	%rsi, %rcx
               	jmp	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	cmpl	$0xff, %ecx
               	jne	<addr>
               	movl	$0x1, %ecx
               	xorl	%edx, %edx
               	testl	%eax, %eax
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	cmpl	$0xff, %ecx
               	jne	<addr>
               	movl	$0x1, %ecx
               	xorl	%edx, %edx
               	testl	%eax, %eax
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	cmpl	$0xff, %ecx
               	jne	<addr>
               	movl	$0x1, %ecx
               	xorl	%edx, %edx
               	testl	%eax, %eax
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
               	jmp	<addr>
               	cmpl	$0xff, %ecx
               	jne	<addr>
               	movl	$0x1, %ecx
               	xorl	%edx, %edx
               	testl	%eax, %eax
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
               	jmp	<addr>
               	cmpl	$0xff, %ecx
               	jne	<addr>
               	movl	$0x1, %ecx
               	xorl	%edx, %edx
               	testl	%eax, %eax
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
               	jmp	<addr>
               	cmpl	$0x7ff, %ecx            # imm = 0x7FF
               	jne	<addr>
               	movl	$0x1, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
               	jmp	<addr>
               	cmpl	$0xff, %edx
               	jne	<addr>
               	movl	$0x1, %edx
               	testl	%eax, %eax
               	movq	%rdx, %rax
               	cmovneq	%rcx, %rax
               	jmp	<addr>
               	cmpl	$0xff, %eax
               	jne	<addr>
               	jmp	<addr>
               	cmpl	$0xff, %eax
               	jne	<addr>
               	jmp	<addr>
               	cmpl	$0xff, %edx
               	jne	<addr>
               	jmp	<addr>
               	cmpl	$0x7ff, %edx            # imm = 0x7FF
               	jne	<addr>
               	jmp	<addr>
