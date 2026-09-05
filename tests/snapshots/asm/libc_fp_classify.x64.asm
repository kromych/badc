
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
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movq	%rcx, %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movq	%rax, %xmm14
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
               	movq	%rax, %xmm1
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
               	movq	%rcx, %xmm14
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
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movl	$0x40a00000, %edx       # imm = 0x40A00000
               	movq	%rdx, %xmm1
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movq	%rax, %xmm14
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
               	movq	%rax, %xmm2
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
               	movq	-0x10(%rbp), %rax
               	shrq	$0x3f, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x10(%rbp,%riz)
               	movq	-0x10(%rbp), %rax
               	shrq	$0x3f, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorq	%rdx, %rdx
               	movq	%rdx, %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	%xmm0, -0x10(%rbp,%riz)
               	movq	-0x10(%rbp), %rax
               	shrq	$0x3f, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x10(%rbp,%riz)
               	movl	$0x2, %eax
               	movq	%rax, %rsi
               	movq	%rax, %rsi
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x10(%rbp,%riz)
               	movq	-0x10(%rbp), %rcx
               	movq	%rcx, %rsi
               	shrq	$0x34, %rsi
               	andq	$0x7ff, %rsi            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	testq	%rsi, %rsi
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	%rax, %rcx
               	movslq	%ecx, %rcx
               	cmpq	$0x4, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movabsq	$0x7fe1ccf385ebc8a0, %rcx # imm = 0x7FE1CCF385EBC8A0
               	movabsq	$0x4024000000000000, %rdx # imm = 0x4024000000000000
               	movq	%rdx, %xmm15
               	movq	%rcx, %xmm0
               	mulsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x10(%rbp,%riz)
               	movq	-0x10(%rbp), %rcx
               	movq	%rcx, %rdx
               	shrq	$0x34, %rdx
               	andq	$0x7ff, %rdx            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	testq	%rdx, %rdx
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %xmm15
               	movq	%rax, %xmm0
               	divsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x10(%rbp,%riz)
               	movq	-0x10(%rbp), %rcx
               	movq	%rcx, %rdx
               	shrq	$0x34, %rdx
               	andq	$0x7ff, %rdx            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	testq	%rdx, %rdx
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x2, %ecx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movabsq	$0x12688b70e62b, %rcx   # imm = 0x12688B70E62B
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x10(%rbp,%riz)
               	movq	-0x10(%rbp), %rcx
               	movq	%rcx, %rdx
               	shrq	$0x34, %rdx
               	andq	$0x7ff, %rdx            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	testq	%rdx, %rdx
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x2, %eax
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpl	$0x7ff, %edx            # imm = 0x7FF
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	$0x3, %ecx
               	jmp	<addr>
               	cmpl	$0x7ff, %edx            # imm = 0x7FF
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %ecx
               	movslq	%ecx, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movl	$0x4, %ecx
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpl	$0x7ff, %edx            # imm = 0x7FF
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	$0x3, %ecx
               	jmp	<addr>
               	cmpl	$0x7ff, %esi            # imm = 0x7FF
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %edx
               	movslq	%edx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x4, %ecx
               	jmp	<addr>
