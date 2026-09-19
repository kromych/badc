
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
               	movl	$0x6, %eax
               	movl	%eax, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rax
               	leave
               	retq
               	jmp	<addr>
               	movl	$0xa, %eax
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x1, %ecx
               	movl	$0x2, %edx
               	xorq	%rax, %rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rax, %rsi
               	andq	$0x1, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	xchgq	%rdx, %rcx
               	incq	%rax
               	testl	%eax, %eax
               	jl	<addr>
               	leaq	(%rcx,%rcx,2), %rax
               	addq	%rdx, %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %ecx
               	movl	$0x2, %edx
               	xorq	%rax, %rax
               	cmpl	$0x1, %eax
               	jge	<addr>
               	movq	%rax, %rsi
               	andq	$0x1, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	xchgq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x1, %eax
               	jl	<addr>
               	leaq	(%rcx,%rcx,2), %rax
               	addq	%rdx, %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %ecx
               	movl	$0x2, %edx
               	xorq	%rax, %rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	%rax, %rsi
               	andq	$0x1, %rsi
               	testq	%rsi, %rsi
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
               	xorq	%rax, %rax
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
               	xorq	%rax, %rax
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
               	movl	$0x1, %ecx
               	movl	$0x2, %edx
               	movl	$0x3, %esi
               	xorq	%rax, %rax
               	testl	%eax, %eax
               	jge	<addr>
               	movslq	%eax, %rdi
               	imulq	$0x55555556, %rdi, %r8  # imm = 0x55555556
               	sarq	$0x20, %r8
               	movq	%r8, %r9
               	shrq	$0x3f, %r9
               	addq	%r9, %r8
               	leaq	(%r8,%r8,2), %r8
               	subq	%r8, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	xchgq	%rdx, %rcx
               	xchgq	%rdx, %rsi
               	incq	%rax
               	testl	%eax, %eax
               	jl	<addr>
               	imulq	$0x64, %rcx, %rax
               	imulq	$0xa, %rdx, %rcx
               	addq	%rcx, %rax
               	addq	%rsi, %rax
               	cmpq	$0x7b, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %ecx
               	movl	$0x2, %edx
               	movl	$0x3, %esi
               	xorq	%rax, %rax
               	cmpl	$0x1, %eax
               	jge	<addr>
               	movslq	%eax, %rdi
               	imulq	$0x55555556, %rdi, %r8  # imm = 0x55555556
               	sarq	$0x20, %r8
               	movq	%r8, %r9
               	shrq	$0x3f, %r9
               	addq	%r9, %r8
               	leaq	(%r8,%r8,2), %r8
               	subq	%r8, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	xchgq	%rdx, %rcx
               	xchgq	%rdx, %rsi
               	incq	%rax
               	cmpl	$0x1, %eax
               	jl	<addr>
               	imulq	$0x64, %rcx, %rax
               	imulq	$0xa, %rdx, %rcx
               	addq	%rcx, %rax
               	addq	%rsi, %rax
               	cmpq	$0xe7, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %ecx
               	movl	$0x2, %edx
               	movl	$0x3, %esi
               	xorq	%rax, %rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movslq	%eax, %rdi
               	imulq	$0x55555556, %rdi, %r8  # imm = 0x55555556
               	sarq	$0x20, %r8
               	movq	%r8, %r9
               	shrq	$0x3f, %r9
               	addq	%r9, %r8
               	leaq	(%r8,%r8,2), %r8
               	subq	%r8, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	xchgq	%rdx, %rcx
               	xchgq	%rdx, %rsi
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
               	movl	$0x1, %ecx
               	movl	$0x2, %edx
               	movl	$0x3, %esi
               	xorq	%rax, %rax
               	cmpl	$0x7, %eax
               	jge	<addr>
               	movslq	%eax, %rdi
               	imulq	$0x55555556, %rdi, %r8  # imm = 0x55555556
               	sarq	$0x20, %r8
               	movq	%r8, %r9
               	shrq	$0x3f, %r9
               	addq	%r9, %r8
               	leaq	(%r8,%r8,2), %r8
               	subq	%r8, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	xchgq	%rdx, %rcx
               	xchgq	%rdx, %rsi
               	incq	%rax
               	cmpl	$0x7, %eax
               	jl	<addr>
               	imulq	$0x64, %rcx, %rax
               	imulq	$0xa, %rdx, %rcx
               	addq	%rcx, %rax
               	addq	%rsi, %rax
               	cmpq	$0x7b, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movl	$0x7, %ecx
               	movl	$0xa, %ecx
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	xorq	%rax, %rax
               	movabsq	$0x3ff0000000000000, %r11 # imm = 0x3FF0000000000000
               	movq	%r11, %xmm0
               	movabsq	$0x4000000000000000, %r11 # imm = 0x4000000000000000
               	movq	%r11, %xmm1
               	cmpl	$0x1, %eax
               	jge	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	incq	%rax
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
               	xorq	%rax, %rax
               	movabsq	$0x3ff0000000000000, %r11 # imm = 0x3FF0000000000000
               	movq	%r11, %xmm0
               	movabsq	$0x4000000000000000, %r11 # imm = 0x4000000000000000
               	movq	%r11, %xmm1
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
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
               	xorq	%rax, %rax
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
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movl	$0xa, %eax
               	movq	%rax, %rdx
               	movl	$0x28, %eax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movl	$0x50, %eax
               	xorq	%rax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	xorq	%rdi, %rdi
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
               	xorq	%rax, %rax
               	testl	%eax, %eax
               	jge	<addr>
               	incq	%rax
               	testl	%eax, %eax
               	jl	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	xorq	%rax, %rax
               	cmpl	$0x9, %eax
               	jge	<addr>
               	incq	%rax
               	cmpl	$0x9, %eax
               	jl	<addr>
               	cmpl	$0x9, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x24, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdx
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movslq	%eax, %rsi
               	movzbq	(%rdx,%rsi), %rsi
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
               	leaq	<rip>, %rdx
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	testl	%eax, %eax
               	jge	<addr>
               	movslq	%eax, %rsi
               	movzbq	(%rdx,%rsi), %rsi
               	andq	$0x1, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	incq	%rcx
               	incq	%rax
               	testl	%eax, %eax
               	jl	<addr>
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x26, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdx
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	testl	%eax, %eax
               	jge	<addr>
               	movslq	%eax, %rsi
               	movslq	(%rdx,%rsi,4), %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	testl	%eax, %eax
               	jl	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	cmpl	$-0x2, %eax
               	jge	<addr>
               	movslq	%eax, %rsi
               	movslq	(%rdx,%rsi,4), %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$-0x2, %eax
               	jl	<addr>
               	testq	%rcx, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x27, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdx
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	cmpl	$0x1, %eax
               	jge	<addr>
               	movslq	%eax, %rsi
               	movslq	(%rdx,%rsi,4), %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x1, %eax
               	jl	<addr>
               	cmpq	$0x3, %rcx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movslq	%eax, %rsi
               	movslq	(%rdx,%rsi,4), %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	cmpq	$0x9, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x28, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	xorq	%rax, %rax
               	movsbq	(%rcx,%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	movsbq	(%rcx,%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	xorq	%rax, %rax
               	movsbq	(%rcx,%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	movsbq	(%rcx,%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	xorq	%rax, %rax
               	movsbq	(%rcx,%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	movsbq	(%rcx,%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	cmpq	$0x7, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x29, %eax
               	popq	%rbp
               	retq
               	xorq	%rdx, %rdx
               	movq	%rdx, %rcx
               	testl	%edx, %edx
               	jge	<addr>
               	xorq	%rax, %rax
               	cmpl	$0x5, %eax
               	jge	<addr>
               	leaq	(%rdx,%rdx,4), %rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	incq	%rdx
               	testl	%edx, %edx
               	jl	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorq	%rdx, %rdx
               	movq	%rdx, %rcx
               	cmpl	$0x3, %edx
               	jge	<addr>
               	xorq	%rax, %rax
               	testl	%eax, %eax
               	jge	<addr>
               	imulq	$0x0, %rdx, %rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	testl	%eax, %eax
               	jl	<addr>
               	incq	%rdx
               	cmpl	$0x3, %edx
               	jl	<addr>
               	testq	%rcx, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rdx, %rdx
               	movq	%rdx, %rcx
               	cmpl	$0x1, %edx
               	jge	<addr>
               	xorq	%rax, %rax
               	cmpl	$0x1, %eax
               	jge	<addr>
               	movq	%rdx, %rsi
               	shlq	$0x0, %rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x1, %eax
               	jl	<addr>
               	incq	%rdx
               	cmpl	$0x1, %edx
               	jl	<addr>
               	testq	%rcx, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2b, %eax
               	popq	%rbp
               	retq
               	xorq	%rdx, %rdx
               	movq	%rdx, %rcx
               	cmpl	$0x3, %edx
               	jge	<addr>
               	xorq	%rax, %rax
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
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movq	%rcx, %rdx
               	movl	$0x1, %eax
               	movq	%rcx, %rdx
               	testl	%eax, %eax
               	je	<addr>
               	movl	%edx, %eax
               	leaq	0x1(%rax), %rdx
               	movq	%rcx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	%edx, %eax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xff, %eax
               	xorq	%rcx, %rcx
               	testl	%eax, %eax
               	je	<addr>
               	shrq	%rax
               	movl	%ecx, %ecx
               	incq	%rcx
               	testl	%eax, %eax
               	jne	<addr>
               	movl	%ecx, %eax
               	xorq	$0x8, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2d, %eax
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	popq	%rbp
               	retq
