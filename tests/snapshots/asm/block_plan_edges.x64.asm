
block_plan_edges.x64:	file format elf64-x86-64

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

<dispatch>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	%edi, -0x20(%rbp)
               	movl	%esi, -0x10(%rbp)
               	leaq	<rip>, %rax
               	movq	%rdi, %rcx
               	andq	$0x3, %rcx
               	movq	(%rax,%rcx,8), %rax
               	jmpq	*%rax
               	movl	$0x6, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rax
               	leave
               	retq
               	jmp	<addr>
               	movl	$0xa, -0x10(%rbp)
               	jmp	<addr>

<scaled>:
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movq	%rax, %rdx
               	imulq	%rdi, %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x3e8, %eax            # imm = 0x3E8
               	jl	<addr>
               	movq	%rcx, %rax
               	retq

<split16>:
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movq	%rax, %rdx
               	andq	$0x7, %rdx
               	movslq	(%rdi,%rdx,4), %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	movslq	(%rdi,%rdx,4), %rdx
               	addq	%rdx, %rcx
               	jmp	<addr>
               	subq	%rax, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, %rax
               	retq

<low_word_skip>:
               	xorl	%ecx, %ecx
               	movabsq	$0x100000000, %rax      # imm = 0x100000000
               	jmp	<addr>
               	testb	$0x1, %al
               	je	<addr>
               	addq	$0x3, %rcx
               	jmp	<addr>
               	addq	$0x5, %rcx
               	addq	%rdi, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%rcx, %rax
               	retq

<mask_skip>:
               	xorl	%eax, %eax
               	movabsq	$0x100000000, %rcx      # imm = 0x100000000
               	jmp	<addr>
               	testb	$0x1, %cl
               	je	<addr>
               	addq	$0x3, %rax
               	jmp	<addr>
               	addq	$0x5, %rax
               	addq	%rdi, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	retq

<low_word_trips>:
               	xorl	%ecx, %ecx
               	movabsq	$0x100000003, %rax      # imm = 0x100000003
               	testb	$0x1, %al
               	je	<addr>
               	addq	$0x3, %rcx
               	jmp	<addr>
               	addq	$0x5, %rcx
               	subq	%rdi, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%rcx, %rax
               	retq

<wraps>:
               	xorl	%eax, %eax
               	movl	$0xfffffffe, %ecx       # imm = 0xFFFFFFFE
               	testb	$0x1, %cl
               	je	<addr>
               	movq	%rdi, %rdx
               	shlq	%rdx
               	addq	%rdx, %rax
               	jmp	<addr>
               	imulq	$0x7, %rdi, %rdx
               	addq	%rdx, %rax
               	incq	%rcx
               	movq	%rcx, %rdx
               	xorq	$0x1, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movl	%eax, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x1, %edx
               	movl	$0x2, %ecx
               	xorl	%eax, %eax
               	movq	%rdx, %rsi
               	movq	%rdx, %rax
               	cmpl	$0x1, %eax
               	jl	<addr>
               	leaq	(%rsi,%rsi,2), %rax
               	addq	%rcx, %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %ecx
               	movl	$0x2, %edx
               	xorl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	xchgq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	(%rcx,%rcx,2), %rax
               	addq	%rdx, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %ecx
               	movl	$0x2, %edx
               	xorl	%eax, %eax
               	testb	$0x1, %al
               	je	<addr>
               	xchgq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	(%rcx,%rcx,2), %rax
               	addq	%rdx, %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %ecx
               	movl	$0x2, %edx
               	xorl	%eax, %eax
               	testb	$0x1, %al
               	je	<addr>
               	xchgq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x7, %eax
               	jl	<addr>
               	leaq	(%rcx,%rcx,2), %rax
               	addq	%rdx, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %esi
               	movl	$0x2, %ecx
               	movl	$0x3, %edx
               	xorl	%eax, %eax
               	movq	%rsi, %rdi
               	movq	%rsi, %rax
               	xchgq	%rdi, %rdx
               	xchgq	%rcx, %rdi
               	cmpl	$0x1, %eax
               	jl	<addr>
               	imulq	$0x64, %rdi, %rax
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	cmpq	$0xe7, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %ecx
               	movl	$0x2, %edx
               	movl	$0x3, %esi
               	xorl	%eax, %eax
               	imulq	$0x55555556, %rax, %rdi # imm = 0x55555556
               	shrq	$0x20, %rdi
               	leaq	(%rdi,%rdi,2), %r8
               	movq	%rax, %rdi
               	subq	%r8, %rdi
               	testl	%edi, %edi
               	jne	<addr>
               	xchgq	%rdx, %rcx
               	xchgq	%rsi, %rdx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	imulq	$0x64, %rcx, %rax
               	imulq	$0xa, %rdx, %rcx
               	addq	%rcx, %rax
               	addq	%rsi, %rax
               	cmpq	$0x138, %rax            # imm = 0x138
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	movl	$0x2, %ecx
               	movl	$0x3, %edx
               	xorl	%eax, %eax
               	movq	%rdi, %rsi
               	imulq	$0x55555556, %rax, %r8  # imm = 0x55555556
               	shrq	$0x20, %r8
               	leaq	(%r8,%r8,2), %r9
               	movq	%rax, %r8
               	subq	%r9, %r8
               	testl	%r8d, %r8d
               	jne	<addr>
               	xchgq	%rcx, %rsi
               	xchgq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x7, %eax
               	jl	<addr>
               	imulq	$0x64, %rsi, %rax
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	cmpq	$0x7b, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	xorl	%eax, %eax
               	movabsq	$0x3ff0000000000000, %r11 # imm = 0x3FF0000000000000
               	movq	%r11, %xmm0
               	movabsq	$0x4000000000000000, %r11 # imm = 0x4000000000000000
               	movq	%r11, %xmm1
               	movq	%rdi, %rax
               	cmpl	$0x1, %eax
               	jl	<addr>
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movapd	%xmm0, %xmm14
               	movq	%rax, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	xorl	%eax, %eax
               	movabsq	$0x3ff0000000000000, %r11 # imm = 0x3FF0000000000000
               	movq	%r11, %xmm0
               	movabsq	$0x4000000000000000, %r11 # imm = 0x4000000000000000
               	movq	%r11, %xmm1
               	testq	%rax, %rax
               	je	<addr>
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movapd	%xmm0, %xmm14
               	movq	%rax, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movabsq	$0x4022000000000000, %rax # imm = 0x4022000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	xorl	%eax, %eax
               	movabsq	$0x3ff0000000000000, %r11 # imm = 0x3FF0000000000000
               	movq	%r11, %xmm0
               	movabsq	$0x4000000000000000, %r11 # imm = 0x4000000000000000
               	movq	%r11, %xmm1
               	testb	$0x1, %al
               	je	<addr>
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movapd	%xmm0, %xmm14
               	movq	%rax, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbp
               	retq
               	xorl	%edi, %edi
               	movl	$0x5, %esi
               	callq	<addr>
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x20, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	movl	$0x5, %esi
               	callq	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x21, %eax
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	movl	$0x5, %esi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x22, %eax
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	movl	$0x5, %esi
               	callq	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x23, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	incq	%rax
               	cmpl	$0x9, %eax
               	jl	<addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x24, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movzbq	(%rdx,%rax), %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	incq	%rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	cmpl	$0x5, %ecx
               	je	<addr>
               	movl	$0x25, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	addq	$0x3, %rcx
               	movl	$0x1, %eax
               	cmpl	$0x1, %eax
               	jl	<addr>
               	cmpq	$0x3, %rcx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movslq	(%rdx,%rax,4), %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	cmpq	$0x9, %rcx
               	je	<addr>
               	movl	$0x28, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x29, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	xorl	%edx, %edx
               	movq	%rdx, %rax
               	movl	$0x1, %eax
               	movq	%rdx, %rsi
               	cmpl	$0x1, %eax
               	jl	<addr>
               	movl	$0x1, %ecx
               	cmpl	$0x1, %ecx
               	jl	<addr>
               	xorl	%edx, %edx
               	movq	%rdx, %rcx
               	xorl	%eax, %eax
               	movq	%rdx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	incq	%rdx
               	cmpl	$0x3, %edx
               	jl	<addr>
               	cmpq	$0x42, %rcx
               	je	<addr>
               	movl	$0x2c, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	xorl	%edx, %edx
               	movq	%rdx, %rcx
               	incq	%rcx
               	movq	%rdx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%rcx, %rax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0xff, %eax
               	xorl	%ecx, %ecx
               	shrq	%rax
               	incq	%rcx
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%rcx, %rax
               	xorq	$0x8, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x2d, %eax
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	cmpq	$0xf3e58, %rax          # imm = 0xF3E58
               	jne	<addr>
               	movq	$-0x1, %rdi
               	callq	<addr>
               	cmpq	$-0x79f2c, %rax         # imm = 0xFFF860D4
               	je	<addr>
               	movl	$0x2e, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	callq	<addr>
               	cmpq	$-0x3c, %rax
               	je	<addr>
               	movl	$0x2f, %eax
               	popq	%rbp
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x30, %eax
               	popq	%rbp
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x31, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0xb, %rax
               	jne	<addr>
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x32, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	xorq	$0x10, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3, %edi
               	callq	<addr>
               	xorq	$0x30, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x33, %eax
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	popq	%rbp
               	retq
