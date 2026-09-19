
libc_fp_classify.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x10(%rbp,%riz)
               	movsd	%xmm0, -0x8(%rbp,%riz)
               	movq	-0x10(%rbp), %rdx
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%r11, %rdx
               	movq	-0x8(%rbp), %rsi
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	andq	%r11, %rsi
               	orq	%rsi, %rdx
               	movq	%rdx, -0x10(%rbp)
               	movsd	-0x10(%rbp,%riz), %xmm2
               	movq	%rcx, %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	ucomisd	%xmm1, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movsd	%xmm1, -0x10(%rbp,%riz)
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rbp,%riz)
               	movq	-0x10(%rbp), %rdx
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%r11, %rdx
               	movq	-0x8(%rbp), %rsi
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	andq	%r11, %rsi
               	orq	%rsi, %rdx
               	movq	%rdx, -0x10(%rbp)
               	movsd	-0x10(%rbp,%riz), %xmm1
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x40000000, %ecx       # imm = 0x40000000
               	movl	$0x40a00000, %edx       # imm = 0x40A00000
               	movq	%rdx, %xmm1
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movq	%rcx, %xmm14
               	cvtss2sd	%xmm14, %xmm2
               	cvtss2sd	%xmm1, %xmm1
               	movsd	%xmm2, -0x10(%rbp,%riz)
               	movsd	%xmm1, -0x8(%rbp,%riz)
               	movq	-0x10(%rbp), %rdx
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%r11, %rdx
               	movq	-0x8(%rbp), %rsi
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	andq	%r11, %rsi
               	orq	%rsi, %rdx
               	movq	%rdx, -0x10(%rbp)
               	movsd	-0x10(%rbp,%riz), %xmm1
               	cvtsd2ss	%xmm1, %xmm1
               	movq	%rcx, %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	ucomiss	%xmm2, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movsd	%xmm0, -0x10(%rbp,%riz)
               	movq	-0x10(%rbp), %rcx
               	shrq	$0x3f, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x10(%rbp,%riz)
               	movq	-0x10(%rbp), %rcx
               	shrq	$0x3f, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	%xmm0, -0x10(%rbp,%riz)
               	movq	-0x10(%rbp), %rdx
               	shrq	$0x3f, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x10(%rbp,%riz)
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x10(%rbp,%riz)
               	movq	-0x10(%rbp), %rax
               	movq	%rax, %rdx
               	shrq	$0x34, %rdx
               	andq	$0x7ff, %rdx            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	testq	%rdx, %rdx
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movabsq	$0x7fe1ccf385ebc8a0, %rax # imm = 0x7FE1CCF385EBC8A0
               	movabsq	$0x4024000000000000, %rdx # imm = 0x4024000000000000
               	movq	%rdx, %xmm15
               	movq	%rax, %xmm0
               	mulsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x10(%rbp,%riz)
               	movq	-0x10(%rbp), %rax
               	movq	%rax, %rdx
               	shrq	$0x34, %rdx
               	andq	$0x7ff, %rdx            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	testq	%rdx, %rdx
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movq	%rcx, %xmm15
               	movq	%rcx, %xmm0
               	divsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x10(%rbp,%riz)
               	movq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	shrq	$0x34, %rcx
               	andq	$0x7ff, %rcx            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movabsq	$0x12688b70e62b, %rax   # imm = 0x12688B70E62B
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x10(%rbp,%riz)
               	movq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	shrq	$0x34, %rcx
               	andq	$0x7ff, %rcx            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0xb, %eax
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
               	movl	$0x4, %eax
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
               	movq	%rcx, %rax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpl	$0x7ff, %edx            # imm = 0x7FF
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
