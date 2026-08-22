
math_compare_macros.x64:	file format elf64-x86-64

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
               	xorq	%rax, %rax
               	movq	%rax, %xmm15
               	movq	%rax, %xmm0
               	divsd	%xmm15, %xmm0
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movabsq	$0x3ff0000000000000, %rdx # imm = 0x3FF0000000000000
               	movq	%rcx, %xmm14
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jbe	<addr>
               	movq	%rdx, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	seta	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	seta	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rcx, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setae	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	movq	%rcx, %xmm14
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setae	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setae	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x2, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %rdx # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movq	%rdx, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm14, %xmm15
               	jbe	<addr>
               	movq	%rcx, %xmm14
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setb	%dl
               	movzbq	%dl, %rdx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rdx
               	testq	%rdx, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rcx, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setbe	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	movq	%rax, %xmm14
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setbe	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setbe	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %rsi # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rsi, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm14, %xmm15
               	movl	$0x1, %edx
               	ja	<addr>
               	movq	%rsi, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	seta	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm14, %xmm15
               	ja	<addr>
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	seta	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	movq	%rdx, %xmm15
               	ucomisd	%xmm0, %xmm15
               	movl	$0x1, %ecx
               	ja	<addr>
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	seta	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x5, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movsd	%xmm0, -0x8(%rbp,%riz)
               	movq	-0x8(%rbp), %rcx
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
               	sete	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movabsq	$0x3ff0000000000000, %rdx # imm = 0x3FF0000000000000
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x8(%rbp,%riz)
               	movq	-0x8(%rbp), %rdx
               	movq	%rdx, %rsi
               	shrq	$0x34, %rsi
               	andq	$0x7ff, %rsi            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rdx
               	testq	%rsi, %rsi
               	jne	<addr>
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	$0x2, %eax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rdx
               	xorq	%rax, %rax
               	testq	%rdx, %rdx
               	je	<addr>
               	movabsq	$0x3ff0000000000000, %rdx # imm = 0x3FF0000000000000
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x8(%rbp,%riz)
               	movq	-0x8(%rbp), %rdx
               	movq	%rdx, %rsi
               	shrq	$0x34, %rsi
               	andq	$0x7ff, %rsi            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rdx
               	testq	%rsi, %rsi
               	jne	<addr>
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	$0x2, %ecx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	movl	$0x1, %edx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movsd	%xmm0, -0x8(%rbp,%riz)
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, %rsi
               	shrq	$0x34, %rsi
               	andq	$0x7ff, %rsi            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	testq	%rsi, %rsi
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x2, %eax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rbp,%riz)
               	movq	-0x8(%rbp), %rax
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
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rdx
               	movl	$0x1, %eax
               	testq	%rdx, %rdx
               	jne	<addr>
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x8(%rbp,%riz)
               	movq	-0x8(%rbp), %rdx
               	movq	%rdx, %rsi
               	shrq	$0x34, %rsi
               	andq	$0x7ff, %rsi            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rdx
               	testq	%rsi, %rsi
               	jne	<addr>
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	$0x2, %eax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x6, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpq	$0x7ff, %rsi            # imm = 0x7FF
               	jne	<addr>
               	testq	%rdx, %rdx
               	jne	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpq	$0x7ff, %rdx            # imm = 0x7FF
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpq	$0x7ff, %rsi            # imm = 0x7FF
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	%edx, %rax
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movq	%rdx, %rax
               	jmp	<addr>
               	movl	$0x3, %ecx
               	jmp	<addr>
               	cmpq	$0x7ff, %rsi            # imm = 0x7FF
               	jne	<addr>
               	testq	%rdx, %rdx
               	jne	<addr>
               	movslq	%ecx, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movl	$0x4, %ecx
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpq	$0x7ff, %rsi            # imm = 0x7FF
               	jne	<addr>
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rcx, %rax
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movl	$0x3, %ecx
               	jmp	<addr>
               	cmpq	$0x7ff, %rdx            # imm = 0x7FF
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
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rdx, %rsi
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
