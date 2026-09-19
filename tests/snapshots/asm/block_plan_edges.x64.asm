
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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x1, %edx
               	movl	$0x2, %ecx
               	xorl	%eax, %eax
               	movq	%rdx, %rsi
               	cmpl	$0x1, %eax
               	jge	<addr>
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
               	cmpl	$0x2, %eax
               	jge	<addr>
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
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	%rax, %rsi
               	andq	$0x1, %rsi
               	testq	%rsi, %rsi
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
               	cmpl	$0x7, %eax
               	jge	<addr>
               	movq	%rax, %rsi
               	andq	$0x1, %rsi
               	testq	%rsi, %rsi
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
               	cmpl	$0x1, %eax
               	jge	<addr>
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
               	cmpl	$0x4, %eax
               	jge	<addr>
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
               	cmpl	$0x7, %eax
               	jge	<addr>
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
               	cmpl	$0x1, %eax
               	jge	<addr>
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
               	cmpl	$0x2, %eax
               	jge	<addr>
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
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
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
               	cmpl	$0x9, %eax
               	jge	<addr>
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
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movzbq	(%rdx,%rax), %rsi
               	andq	$0x1, %rsi
               	testq	%rsi, %rsi
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
               	cmpl	$0x1, %eax
               	jge	<addr>
               	addq	$0x3, %rcx
               	movl	$0x1, %eax
               	cmpl	$0x1, %eax
               	jl	<addr>
               	cmpq	$0x3, %rcx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	$0x8, %eax
               	jge	<addr>
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
               	cmpl	$0x3, %eax
               	jge	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	xorl	%edx, %edx
               	movq	%rdx, %rcx
               	cmpl	$0x1, %edx
               	jge	<addr>
               	xorl	%eax, %eax
               	cmpl	$0x1, %eax
               	jge	<addr>
               	movq	%rdx, %rsi
               	shlq	$0x0, %rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	addq	%rsi, %rcx
               	movl	$0x1, %eax
               	cmpl	$0x1, %eax
               	jl	<addr>
               	movl	$0x1, %edx
               	cmpl	$0x1, %edx
               	jl	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2b, %eax
               	popq	%rbp
               	retq
               	xorl	%edx, %edx
               	movq	%rdx, %rcx
               	cmpl	$0x3, %edx
               	jge	<addr>
               	xorl	%eax, %eax
               	cmpl	$0x4, %eax
               	jge	<addr>
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
               	testl	%eax, %eax
               	je	<addr>
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
               	testl	%eax, %eax
               	je	<addr>
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
               	movl	$0x2a, %eax
               	popq	%rbp
               	retq
