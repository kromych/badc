
math_classify_type_generic.x64:	file format elf64-x86-64

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
               	subq	$0x88, %rsp
               	movl	$0x400000, 0x50(%rsp)   # imm = 0x400000
               	movl	$0x800000, 0x58(%rsp)   # imm = 0x800000
               	movl	$0x7fc00000, 0x60(%rsp) # imm = 0x7FC00000
               	movl	$0x80000000, 0x68(%rsp) # imm = 0x80000000
               	movsd	<rip>, %xmm1
               	movsd	%xmm1, 0x70(%rsp)
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, 0x78(%rsp)
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%rsp)
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x10(%rsp)
               	movabsq	$0x7ff0000000000000, %rax # imm = 0x7FF0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x20(%rsp)
               	movsd	0x78(%rsp), %xmm1
               	movq	%xmm1, %rax
               	shrq	$0x34, %rax
               	andq	$0x7ff, %rax            # imm = 0x7FF
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	addq	$0x88, %rsp
               	retq
               	cmpl	$0x7ff, %eax            # imm = 0x7FF
               	je	<addr>
               	movsd	0x70(%rsp), %xmm1
               	movq	%xmm1, %rax
               	shrq	$0x34, %rax
               	andq	$0x7ff, %rax            # imm = 0x7FF
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x7f800000, 0x48(%rsp) # imm = 0x7F800000
               	movl	0x48(%rsp), %eax
               	shrq	$0x17, %rax
               	andq	$0xff, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x7fc00000, 0x48(%rsp) # imm = 0x7FC00000
               	movl	0x48(%rsp), %eax
               	shrq	$0x17, %rax
               	andq	$0xff, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3f800000, 0x48(%rsp) # imm = 0x3F800000
               	movl	0x48(%rsp), %eax
               	shrq	$0x17, %rax
               	andq	$0xff, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	addq	$0x88, %rsp
               	retq
               	cmpl	$0xff, %eax
               	je	<addr>
               	movss	0x58(%rsp), %xmm0
               	movss	%xmm0, 0x48(%rsp)
               	movl	0x48(%rsp), %eax
               	shrq	$0x17, %rax
               	andq	$0xff, %rax
               	testl	%eax, %eax
               	je	<addr>
               	cmpl	$0xff, %eax
               	je	<addr>
               	movss	0x50(%rsp), %xmm0
               	movss	%xmm0, 0x48(%rsp)
               	movl	0x48(%rsp), %eax
               	shrq	$0x17, %rax
               	andq	$0xff, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movss	0x50(%rsp), %xmm0
               	movss	%xmm0, 0x48(%rsp)
               	movl	0x48(%rsp), %eax
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
               	movss	0x50(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%xmm0, %rax
               	shrq	$0x34, %rax
               	andq	$0x7ff, %rax            # imm = 0x7FF
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3, %eax
               	addq	$0x88, %rsp
               	retq
               	cmpl	$0x7ff, %eax            # imm = 0x7FF
               	je	<addr>
               	movsd	0x70(%rsp), %xmm0
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
               	movss	0x68(%rsp), %xmm0
               	movss	%xmm0, 0x48(%rsp)
               	movl	0x48(%rsp), %eax
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
               	addq	$0x88, %rsp
               	retq
               	movss	0x60(%rsp), %xmm0
               	movss	%xmm0, 0x48(%rsp)
               	movl	0x48(%rsp), %eax
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
               	movss	0x60(%rsp), %xmm0
               	movss	%xmm0, 0x48(%rsp)
               	movl	0x48(%rsp), %eax
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
               	movss	0x60(%rsp), %xmm0
               	movss	%xmm0, 0x48(%rsp)
               	movl	0x48(%rsp), %eax
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
               	movss	0x50(%rsp), %xmm0
               	movss	%xmm0, 0x48(%rsp)
               	movl	0x48(%rsp), %eax
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
               	addq	$0x88, %rsp
               	retq
               	movss	0x68(%rsp), %xmm0
               	movss	%xmm0, 0x48(%rsp)
               	movl	0x48(%rsp), %eax
               	shrq	$0x1f, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movss	0x58(%rsp), %xmm0
               	movss	%xmm0, 0x48(%rsp)
               	movl	0x48(%rsp), %eax
               	shrq	$0x1f, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movss	0x50(%rsp), %xmm0
               	vxorpd	<rip>, %xmm0, %xmm0
               	movss	%xmm0, 0x48(%rsp)
               	movl	0x48(%rsp), %eax
               	shrq	$0x1f, %rax
               	testl	%eax, %eax
               	je	<addr>
               	fldt	(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x30(%rsp)
               	fldt	0x30(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movq	%xmm0, %rax
               	shrq	$0x34, %rax
               	andq	$0x7ff, %rax            # imm = 0x7FF
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x7, %eax
               	addq	$0x88, %rsp
               	retq
               	cmpl	$0x7ff, %eax            # imm = 0x7FF
               	je	<addr>
               	fldt	0x10(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x30(%rsp)
               	fldt	0x30(%rsp)
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
               	cmpl	$0x2, %eax
               	jne	<addr>
               	fldt	0x20(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x30(%rsp)
               	fldt	0x30(%rsp)
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
               	fldt	(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	0x30(%rsp)
               	fldt	0x30(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movq	%xmm0, %rax
               	shrq	$0x3f, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movss	0x60(%rsp), %xmm0
               	movss	%xmm0, 0x48(%rsp)
               	movl	0x48(%rsp), %eax
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
               	movss	0x60(%rsp), %xmm0
               	ucomiss	<rip>, %xmm0
               	jnp	<addr>
               	movsd	0x78(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jnp	<addr>
               	movl	$0x9, %eax
               	addq	$0x88, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x88, %rsp
               	retq
               	movl	$0x8, %eax
               	addq	$0x88, %rsp
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
               	cmpl	$0x7ff, %ecx            # imm = 0x7FF
               	jne	<addr>
               	movl	$0x1, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
               	jmp	<addr>
               	movl	$0x6, %eax
               	addq	$0x88, %rsp
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
               	je	<addr>
               	jmp	<addr>
               	cmpl	$0xff, %eax
               	je	<addr>
               	jmp	<addr>
               	cmpl	$0xff, %eax
               	je	<addr>
               	jmp	<addr>
               	cmpl	$0x7ff, %eax            # imm = 0x7FF
               	je	<addr>
               	jmp	<addr>
