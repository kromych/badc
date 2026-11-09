
x86_f16c_conversions_match_the_instructions.x64:	file format elf64-x86-64

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

<__badc_f32_to_f16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rsi, %r12
               	movl	%edi, %edi
               	movq	%rdi, %rax
               	shrq	$0x10, %rax
               	andq	$0x8000, %rax           # imm = 0x8000
               	movq	%rdi, %r8
               	shrq	$0x17, %r8
               	andq	$0xff, %r8
               	andq	$0x7fffff, %rdi         # imm = 0x7FFFFF
               	cmpl	$0xff, %r8d
               	jne	<addr>
               	testl	%edi, %edi
               	jne	<addr>
               	orq	$0x7c00, %rax           # imm = 0x7C00
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	testl	$0x400000, %edi         # imm = 0x400000
               	jne	<addr>
               	movl	(%rcx), %edx
               	orq	$0x1, %rdx
               	movl	%edx, (%rcx)
               	orq	$0x7e00, %rax           # imm = 0x7E00
               	movq	%rdi, %rcx
               	shrq	$0xd, %rcx
               	orq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	testl	%r8d, %r8d
               	jne	<addr>
               	testl	%edi, %edi
               	je	<addr>
               	testb	$0x40, %dl
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	(%rcx), %edx
               	orq	$0x2, %rdx
               	movl	%edx, (%rcx)
               	testq	%r8, %r8
               	je	<addr>
               	orq	$0x800000, %rdi         # imm = 0x800000
               	testq	%r8, %r8
               	je	<addr>
               	leaq	-0x96(%r8), %r9
               	leaq	0x1f(%r9), %r8
               	movl	$0x3f, %r11d
               	bsrl	%edi, %edx
               	cmovel	%r11d, %edx
               	xorl	$0x1f, %edx
               	subq	%rdx, %r8
               	cmpl	$-0xe, %r8d
               	jl	<addr>
               	leaq	-0xa(%r8), %rdx
               	subq	%r9, %rdx
               	cmpl	$0x20, %edx
               	jge	<addr>
               	shrxq	%rdx, %rdi, %rsi
               	cmpl	$0x20, %edx
               	jge	<addr>
               	movl	$0x1, %r9d
               	shlxq	%rdx, %r9, %r9
               	decq	%r9
               	andq	%rdi, %r9
               	cmpl	$0x40, %edx
               	jge	<addr>
               	movl	$0x1, %ebx
               	decq	%rdx
               	shlxq	%rdx, %rbx, %rbx
               	testl	%r9d, %r9d
               	jne	<addr>
               	xorl	%edx, %edx
               	addq	%rdx, %rsi
               	cmpl	$-0xe, %r8d
               	jl	<addr>
               	leaq	0xf(%r8), %rdx
               	shlq	$0xa, %rdx
               	addq	%rsi, %rdx
               	leaq	-0x400(%rdx), %rsi
               	cmpl	$0x7c00, %esi           # imm = 0x7C00
               	jb	<addr>
               	movl	(%rcx), %edx
               	orq	$0x28, %rdx
               	movl	%edx, (%rcx)
               	movq	%r12, %rsi
               	andq	$0x3, %rsi
               	movl	$0x1, %ecx
               	testl	%esi, %esi
               	je	<addr>
               	movq	%rsi, %rdi
               	xorq	$0x1, %rdi
               	xorl	%edx, %edx
               	testl	%edi, %edi
               	jne	<addr>
               	testl	%eax, %eax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rsi, %rdx
               	xorq	$0x2, %rdx
               	xorl	%ecx, %ecx
               	testl	%edx, %edx
               	jne	<addr>
               	testl	%eax, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x7c00, %ecx           # imm = 0x7C00
               	orq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x7bff, %ecx           # imm = 0x7BFF
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	testq	%r9, %r9
               	je	<addr>
               	movq	%rdi, %r9
               	shrq	$0xd, %r9
               	cmpl	$-0xf, %r8d
               	movl	$0x1, %edx
               	jl	<addr>
               	cmpl	$-0xf, %r8d
               	sete	%r8b
               	movzbq	%r8b, %r8
               	xorl	%edx, %edx
               	testq	%r8, %r8
               	je	<addr>
               	andq	$0x1fff, %rdi           # imm = 0x1FFF
               	movl	$0x1000, %r8d           # imm = 0x1000
               	testl	%edi, %edi
               	jne	<addr>
               	xorl	%edx, %edx
               	addq	%r9, %rdx
               	cmpl	$0x800, %edx            # imm = 0x800
               	setb	%dl
               	movzbq	%dl, %rdx
               	movl	(%rcx), %edi
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x10, %edx
               	orq	$0x20, %rdx
               	orq	%rdi, %rdx
               	movl	%edx, (%rcx)
               	orq	%rsi, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%edx, %edx
               	jmp	<addr>
               	movq	%r12, %rdx
               	andq	$0x3, %rdx
               	cmpl	$0x1, %edx
               	jb	<addr>
               	cmpl	$0x2, %edx
               	jb	<addr>
               	cmpl	$0x2, %edx
               	je	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	testl	%eax, %eax
               	sete	%dl
               	movzbq	%dl, %rdx
               	jmp	<addr>
               	testl	%eax, %eax
               	setne	%dl
               	movzbq	%dl, %rdx
               	jmp	<addr>
               	cmpl	%r8d, %edi
               	movl	$0x1, %edx
               	ja	<addr>
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	xorl	%edx, %edx
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%r9, %rdx
               	andq	$0x1, %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	jmp	<addr>
               	movq	%r12, %rdx
               	andq	$0x3, %rdx
               	cmpl	$0x1, %edx
               	jb	<addr>
               	cmpl	$0x2, %edx
               	jb	<addr>
               	cmpl	$0x2, %edx
               	je	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	testl	%eax, %eax
               	sete	%dl
               	movzbq	%dl, %rdx
               	jmp	<addr>
               	testl	%eax, %eax
               	setne	%dl
               	movzbq	%dl, %rdx
               	jmp	<addr>
               	cmpq	%rbx, %r9
               	movl	$0x1, %edx
               	ja	<addr>
               	cmpq	%rbx, %r9
               	sete	%bl
               	movzbq	%bl, %rbx
               	xorl	%edx, %edx
               	testq	%rbx, %rbx
               	je	<addr>
               	movq	%rsi, %rdx
               	andq	$0x1, %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	jmp	<addr>
               	movq	$-0x1, %rbx
               	jmp	<addr>
               	movq	%rdi, %r9
               	jmp	<addr>
               	xorl	%esi, %esi
               	jmp	<addr>
               	movq	$-0x18, %rdx
               	jmp	<addr>
               	movq	$-0x95, %r9
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	leaq	-0x10(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x10(%rbp), %r14d
               	xorl	%r13d, %r13d
               	leaq	-0x58(%rbp), %rdx
               	leaq	<rip>, %rax # <addr>
               	imulq	$0x14, %r13, %rcx
               	addq	%rcx, %rax
               	movl	(%rax), %r10d
               	movl	%r10d, (%rdx)
               	movl	0x8(%rax), %eax
               	movl	%eax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	ldmxcsr	(%rax)
               	movss	-0x58(%rbp), %xmm0
               	leaq	<rip>, %rax # <addr>
               	addq	%rcx, %rax
               	movl	0x4(%rax), %eax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	cmpl	$0x3, %eax
               	jl	<addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	movss	%xmm0, -0x50(%rbp)
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %ebx
               	xorl	%eax, %eax
               	movl	%eax, -0x38(%rbp)
               	movq	%rbx, %r12
               	shrq	$0xd, %r12
               	andq	$0x3, %r12
               	movss	-0x50(%rbp), %xmm0
               	movl	$0x0, -0x18(%rbp)
               	movss	%xmm0, -0x18(%rbp)
               	movl	-0x18(%rbp), %edi
               	leaq	-0x38(%rbp), %rcx
               	movq	%r12, %rsi
               	movq	%rbx, %rdx
               	callq	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x48(%rbp)
               	movl	$0x1, %eax
               	cmpl	$0x1, %eax
               	jl	<addr>
               	cmpl	$0x0, -0x38(%rbp)
               	je	<addr>
               	movl	-0x38(%rbp), %eax
               	orq	%rbx, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movzwq	-0x48(%rbp), %rcx
               	leaq	-0x10(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x10(%rbp), %eax
               	movq	%rax, %rdx
               	andq	$0x3f, %rdx
               	movl	%r14d, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	ldmxcsr	(%rax)
               	leaq	<rip>, %rax # <addr>
               	imulq	$0x14, %r13, %rsi
               	addq	%rsi, %rax
               	movl	0xc(%rax), %eax
               	cmpl	%eax, %ecx
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	imulq	$0x14, %r13, %rcx
               	addq	%rcx, %rax
               	movl	0x10(%rax), %eax
               	cmpl	%eax, %edx
               	je	<addr>
               	jmp	<addr>
               	movss	%xmm0, -0x50(%rbp)
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %ebx
               	xorl	%eax, %eax
               	movl	%eax, -0x38(%rbp)
               	movss	-0x50(%rbp), %xmm0
               	movl	$0x0, -0x18(%rbp)
               	movss	%xmm0, -0x18(%rbp)
               	movl	-0x18(%rbp), %edi
               	movl	$0x3, %esi
               	leaq	-0x38(%rbp), %rcx
               	movq	%rbx, %rdx
               	callq	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x48(%rbp)
               	movl	$0x1, %eax
               	cmpl	$0x1, %eax
               	jl	<addr>
               	cmpl	$0x0, -0x38(%rbp)
               	je	<addr>
               	movl	-0x38(%rbp), %eax
               	orq	%rbx, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movzwq	-0x48(%rbp), %rcx
               	jmp	<addr>
               	movss	%xmm0, -0x50(%rbp)
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %ebx
               	xorl	%eax, %eax
               	movl	%eax, -0x38(%rbp)
               	movss	-0x50(%rbp), %xmm0
               	movl	$0x0, -0x18(%rbp)
               	movss	%xmm0, -0x18(%rbp)
               	movl	-0x18(%rbp), %edi
               	movl	$0x2, %esi
               	leaq	-0x38(%rbp), %rcx
               	movq	%rbx, %rdx
               	callq	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x48(%rbp)
               	movl	$0x1, %eax
               	cmpl	$0x1, %eax
               	jl	<addr>
               	cmpl	$0x0, -0x38(%rbp)
               	je	<addr>
               	movl	-0x38(%rbp), %eax
               	orq	%rbx, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movzwq	-0x48(%rbp), %rcx
               	jmp	<addr>
               	cmpl	$0x1, %eax
               	jl	<addr>
               	movss	%xmm0, -0x50(%rbp)
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %ebx
               	xorl	%eax, %eax
               	movl	%eax, -0x38(%rbp)
               	movss	-0x50(%rbp), %xmm0
               	movl	$0x0, -0x18(%rbp)
               	movss	%xmm0, -0x18(%rbp)
               	movl	-0x18(%rbp), %edi
               	movl	$0x1, %esi
               	leaq	-0x38(%rbp), %rcx
               	movq	%rbx, %rdx
               	callq	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x48(%rbp)
               	movl	$0x1, %eax
               	cmpl	$0x1, %eax
               	jl	<addr>
               	cmpl	$0x0, -0x38(%rbp)
               	je	<addr>
               	movl	-0x38(%rbp), %eax
               	orq	%rbx, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movzwq	-0x48(%rbp), %rcx
               	jmp	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movss	%xmm0, -0x50(%rbp)
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %ebx
               	xorl	%eax, %eax
               	movl	%eax, -0x38(%rbp)
               	movss	-0x50(%rbp), %xmm0
               	xorl	%esi, %esi
               	movl	%esi, -0x18(%rbp)
               	movss	%xmm0, -0x18(%rbp)
               	movl	-0x18(%rbp), %edi
               	leaq	-0x38(%rbp), %rcx
               	movq	%rbx, %rdx
               	callq	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x48(%rbp)
               	movl	$0x1, %eax
               	cmpl	$0x1, %eax
               	jl	<addr>
               	cmpl	$0x0, -0x38(%rbp)
               	je	<addr>
               	movl	-0x38(%rbp), %eax
               	orq	%rbx, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movzwq	-0x48(%rbp), %rcx
               	jmp	<addr>
               	incq	%r13
               	cmpl	$0x54, %r13d
               	jb	<addr>
               	xorl	%esi, %esi
               	movq	%rsi, %rdx
               	leaq	<rip>, %rax # <addr>
               	movq	%rdx, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rax,%rcx), %r8
               	movzwq	(%r8), %rcx
               	movl	%esi, -0x18(%rbp)
               	movq	%rcx, %rax
               	andq	$0x8000, %rax           # imm = 0x8000
               	shlq	$0x10, %rax
               	movq	%rcx, %rdi
               	shrq	$0xa, %rdi
               	andq	$0x1f, %rdi
               	andq	$0x3ff, %rcx            # imm = 0x3FF
               	cmpl	$0x1f, %edi
               	jne	<addr>
               	movq	%rax, %rdi
               	orq	$0x7f800000, %rdi       # imm = 0x7F800000
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	shlq	$0xd, %rax
               	orq	$0x400000, %rax         # imm = 0x400000
               	orq	%rdi, %rax
               	leaq	-0x58(%rbp), %rcx
               	movl	$0x0, (%rcx)
               	movl	%eax, -0x58(%rbp)
               	movss	-0x58(%rbp), %xmm0
               	movss	%xmm0, -0x48(%rbp)
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x48(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x38(%rbp), %eax
               	movl	0x4(%r8), %ecx
               	cmpl	%ecx, %eax
               	je	<addr>
               	jmp	<addr>
               	movq	%rsi, %rax
               	jmp	<addr>
               	testl	%edi, %edi
               	jne	<addr>
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x1f, %edi
               	bsrl	%ecx, %r9d
               	xorl	$0x1f, %r9d
               	subq	%r9, %rdi
               	leaq	0x67(%rdi), %r9
               	shlq	$0x17, %r9
               	orq	%r9, %rax
               	movl	$0x17, %r9d
               	subq	%rdi, %r9
               	shlxq	%r9, %rcx, %rcx
               	andq	$0x7fffff, %rcx         # imm = 0x7FFFFF
               	orq	%rcx, %rax
               	jmp	<addr>
               	addq	$0x70, %rdi
               	shlq	$0x17, %rdi
               	orq	%rdi, %rax
               	shlq	$0xd, %rcx
               	orq	%rcx, %rax
               	jmp	<addr>
               	incq	%rdx
               	cmpl	$0x9, %edx
               	jb	<addr>
               	leaq	0x20(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movl	$0x3f800000, 0x20(%rsp) # imm = 0x3F800000
               	movl	$0x40000000, 0x24(%rsp) # imm = 0x40000000
               	movl	$0x40400000, 0x28(%rsp) # imm = 0x40400000
               	movl	$0x40800000, 0x2c(%rsp) # imm = 0x40800000
               	movl	$0x40a00000, 0x30(%rsp) # imm = 0x40A00000
               	movl	$0x40c00000, 0x34(%rsp) # imm = 0x40C00000
               	movl	$0x40e00000, 0x38(%rsp) # imm = 0x40E00000
               	movl	$0x41000000, 0x3c(%rsp) # imm = 0x41000000
               	leaq	0x20(%rsp), %rcx
               	leaq	(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x20(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	-0x30(%rbp), %r12
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%r12)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%r12)
               	leaq	-0x40(%rbp), %r14
               	leaq	-0x58(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x58(%rbp), %r13d
               	xorl	%ebx, %ebx
               	movl	%ebx, -0x48(%rbp)
               	movq	%rbx, %rax
               	shlq	$0x2, %rax
               	addq	%r12, %rax
               	movss	(%rax), %xmm0
               	xorl	%esi, %esi
               	movl	%esi, -0x50(%rbp)
               	movss	%xmm0, -0x50(%rbp)
               	movl	-0x50(%rbp), %edi
               	leaq	-0x48(%rbp), %rcx
               	movq	%r13, %rdx
               	callq	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, (%r14,%rbx,2)
               	incq	%rbx
               	cmpl	$0x8, %ebx
               	jl	<addr>
               	cmpl	$0x0, -0x48(%rbp)
               	je	<addr>
               	movl	-0x48(%rbp), %eax
               	orq	%r13, %rax
               	movl	%eax, -0x58(%rbp)
               	leaq	-0x58(%rbp), %rax
               	ldmxcsr	(%rax)
               	leaq	0x20(%rsp), %rax
               	leaq	-0x40(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x20(%rsp), %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	movl	(%rsp), %eax
               	movl	0x4(%rsp), %ecx
               	movl	0x8(%rsp), %edx
               	movl	0xc(%rsp), %esi
               	leaq	0x20(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	%eax, 0x20(%rsp)
               	movl	%ecx, 0x24(%rsp)
               	movl	%edx, 0x28(%rsp)
               	movl	%esi, 0x2c(%rsp)
               	movups	0x20(%rsp), %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	leaq	-0x40(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movss	0x20(%rsp), %xmm0
               	movss	%xmm0, -0x40(%rbp)
               	movss	0x24(%rsp), %xmm0
               	movss	%xmm0, -0x3c(%rbp)
               	movss	0x28(%rsp), %xmm0
               	movss	%xmm0, -0x38(%rbp)
               	movss	0x2c(%rsp), %xmm0
               	leaq	-0x40(%rbp), %r14
               	movss	%xmm0, -0x34(%rbp)
               	leaq	-0x20(%rbp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	leaq	-0x58(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x58(%rbp), %r13d
               	xorl	%ebx, %ebx
               	movl	%ebx, -0x48(%rbp)
               	movq	%rbx, %rax
               	shlq	$0x2, %rax
               	addq	%r14, %rax
               	movss	(%rax), %xmm0
               	xorl	%esi, %esi
               	movl	%esi, -0x50(%rbp)
               	movss	%xmm0, -0x50(%rbp)
               	movl	-0x50(%rbp), %edi
               	leaq	-0x48(%rbp), %rcx
               	movq	%r13, %rdx
               	callq	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, (%r12,%rbx,2)
               	incq	%rbx
               	cmpl	$0x4, %ebx
               	jl	<addr>
               	cmpl	$0x0, -0x48(%rbp)
               	je	<addr>
               	movl	-0x48(%rbp), %eax
               	orq	%r13, %rax
               	movl	%eax, -0x58(%rbp)
               	leaq	-0x58(%rbp), %rax
               	ldmxcsr	(%rax)
               	leaq	0x20(%rsp), %rcx
               	leaq	-0x20(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x20(%rsp), %xmm0
               	leaq	0x20(%rsp), %rcx
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x40(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x30(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	leaq	-0x20(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	%rcx
               	addq	%rcx, %rdx
               	movzwq	(%rdx), %rsi
               	leaq	<rip>, %rdx # <addr>
               	addq	%rdx, %rcx
               	movzwq	(%rcx), %rcx
               	cmpl	%ecx, %esi
               	jne	<addr>
               	leaq	-0x30(%rbp), %rcx
               	movzwq	(%rcx,%rax,2), %rsi
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movzwq	(%rdx,%rax,2), %rcx
               	cmpl	%ecx, %esi
               	je	<addr>
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	cmpl	%ecx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movzwq	0x40(%rsp), %rax
               	movzwq	0x42(%rsp), %rsi
               	movzwq	0x44(%rsp), %rdi
               	movzwq	0x46(%rsp), %r8
               	movzwq	0x48(%rsp), %r9
               	movzwq	0x4a(%rsp), %rbx
               	movzwq	0x4c(%rsp), %r12
               	movzwq	0x4e(%rsp), %r13
               	movswq	%ax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rcx, %rax
               	andq	$0x8000, %rax           # imm = 0x8000
               	shlq	$0x10, %rax
               	movq	%rcx, %rdx
               	shrq	$0xa, %rdx
               	andq	$0x1f, %rdx
               	andq	$0x3ff, %rcx            # imm = 0x3FF
               	cmpl	$0x1f, %edx
               	jne	<addr>
               	movq	%rax, %rdx
               	orq	$0x7f800000, %rdx       # imm = 0x7F800000
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	shlq	$0xd, %rax
               	orq	$0x400000, %rax         # imm = 0x400000
               	orq	%rdx, %rax
               	movl	$0x0, -0x18(%rbp)
               	movl	%eax, -0x18(%rbp)
               	movss	-0x18(%rbp), %xmm0
               	movss	%xmm0, 0x20(%rsp)
               	movswq	%si, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rcx, %rax
               	andq	$0x8000, %rax           # imm = 0x8000
               	shlq	$0x10, %rax
               	movq	%rcx, %rdx
               	shrq	$0xa, %rdx
               	andq	$0x1f, %rdx
               	andq	$0x3ff, %rcx            # imm = 0x3FF
               	cmpl	$0x1f, %edx
               	jne	<addr>
               	movq	%rax, %rdx
               	orq	$0x7f800000, %rdx       # imm = 0x7F800000
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	shlq	$0xd, %rax
               	orq	$0x400000, %rax         # imm = 0x400000
               	orq	%rdx, %rax
               	movl	$0x0, -0x18(%rbp)
               	movl	%eax, -0x18(%rbp)
               	movss	-0x18(%rbp), %xmm0
               	movss	%xmm0, 0x24(%rsp)
               	movswq	%di, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rcx, %rax
               	andq	$0x8000, %rax           # imm = 0x8000
               	shlq	$0x10, %rax
               	movq	%rcx, %rdx
               	shrq	$0xa, %rdx
               	andq	$0x1f, %rdx
               	andq	$0x3ff, %rcx            # imm = 0x3FF
               	cmpl	$0x1f, %edx
               	jne	<addr>
               	movq	%rax, %rdx
               	orq	$0x7f800000, %rdx       # imm = 0x7F800000
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	shlq	$0xd, %rax
               	orq	$0x400000, %rax         # imm = 0x400000
               	orq	%rdx, %rax
               	movl	$0x0, -0x18(%rbp)
               	movl	%eax, -0x18(%rbp)
               	movss	-0x18(%rbp), %xmm0
               	movss	%xmm0, 0x28(%rsp)
               	movswq	%r8w, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rcx, %rax
               	andq	$0x8000, %rax           # imm = 0x8000
               	shlq	$0x10, %rax
               	movq	%rcx, %rdx
               	shrq	$0xa, %rdx
               	andq	$0x1f, %rdx
               	andq	$0x3ff, %rcx            # imm = 0x3FF
               	cmpl	$0x1f, %edx
               	jne	<addr>
               	movq	%rax, %rdx
               	orq	$0x7f800000, %rdx       # imm = 0x7F800000
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	shlq	$0xd, %rax
               	orq	$0x400000, %rax         # imm = 0x400000
               	orq	%rdx, %rax
               	movl	$0x0, -0x18(%rbp)
               	movl	%eax, -0x18(%rbp)
               	movss	-0x18(%rbp), %xmm0
               	movss	%xmm0, 0x2c(%rsp)
               	movswq	%r9w, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rcx, %rax
               	andq	$0x8000, %rax           # imm = 0x8000
               	shlq	$0x10, %rax
               	movq	%rcx, %rdx
               	shrq	$0xa, %rdx
               	andq	$0x1f, %rdx
               	andq	$0x3ff, %rcx            # imm = 0x3FF
               	cmpl	$0x1f, %edx
               	jne	<addr>
               	movq	%rax, %rdx
               	orq	$0x7f800000, %rdx       # imm = 0x7F800000
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	shlq	$0xd, %rax
               	orq	$0x400000, %rax         # imm = 0x400000
               	orq	%rdx, %rax
               	xorl	%edx, %edx
               	movl	%edx, -0x18(%rbp)
               	movl	%eax, -0x18(%rbp)
               	movss	-0x18(%rbp), %xmm0
               	movss	%xmm0, 0x30(%rsp)
               	movswq	%bx, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rcx, %rax
               	andq	$0x8000, %rax           # imm = 0x8000
               	shlq	$0x10, %rax
               	movq	%rcx, %rsi
               	shrq	$0xa, %rsi
               	andq	$0x1f, %rsi
               	andq	$0x3ff, %rcx            # imm = 0x3FF
               	cmpl	$0x1f, %esi
               	jne	<addr>
               	orq	$0x7f800000, %rax       # imm = 0x7F800000
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rdx
               	shlq	$0xd, %rdx
               	orq	$0x400000, %rdx         # imm = 0x400000
               	orq	%rdx, %rax
               	xorl	%edx, %edx
               	movl	%edx, -0x18(%rbp)
               	movl	%eax, -0x18(%rbp)
               	movss	-0x18(%rbp), %xmm0
               	movss	%xmm0, 0x34(%rsp)
               	movswq	%r12w, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rcx, %rax
               	andq	$0x8000, %rax           # imm = 0x8000
               	shlq	$0x10, %rax
               	movq	%rcx, %rsi
               	shrq	$0xa, %rsi
               	andq	$0x1f, %rsi
               	andq	$0x3ff, %rcx            # imm = 0x3FF
               	cmpl	$0x1f, %esi
               	jne	<addr>
               	movq	%rax, %rsi
               	orq	$0x7f800000, %rsi       # imm = 0x7F800000
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	shlq	$0xd, %rax
               	orq	$0x400000, %rax         # imm = 0x400000
               	orq	%rsi, %rax
               	movl	%edx, -0x18(%rbp)
               	movl	%eax, -0x18(%rbp)
               	movss	-0x18(%rbp), %xmm0
               	movss	%xmm0, 0x38(%rsp)
               	movswq	%r13w, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rcx, %rax
               	andq	$0x8000, %rax           # imm = 0x8000
               	shlq	$0x10, %rax
               	movq	%rcx, %rdx
               	shrq	$0xa, %rdx
               	andq	$0x1f, %rdx
               	andq	$0x3ff, %rcx            # imm = 0x3FF
               	cmpl	$0x1f, %edx
               	jne	<addr>
               	movq	%rax, %rdx
               	orq	$0x7f800000, %rdx       # imm = 0x7F800000
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	shlq	$0xd, %rax
               	orq	$0x400000, %rax         # imm = 0x400000
               	orq	%rdx, %rax
               	movl	$0x0, -0x18(%rbp)
               	movl	%eax, -0x18(%rbp)
               	movss	-0x18(%rbp), %xmm0
               	movss	%xmm0, 0x3c(%rsp)
               	movq	0x20(%rsp), %rax
               	movq	0x28(%rsp), %rcx
               	movq	0x30(%rsp), %rdx
               	movq	0x38(%rsp), %rsi
               	movq	%rax, 0x20(%rsp)
               	movq	%rcx, 0x28(%rsp)
               	movq	%rdx, 0x30(%rsp)
               	movq	%rsi, 0x38(%rsp)
               	movzwq	0x40(%rsp), %rax
               	movzwq	0x42(%rsp), %rsi
               	movzwq	0x44(%rsp), %rdi
               	movzwq	0x46(%rsp), %r8
               	movswq	%ax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rcx, %rax
               	andq	$0x8000, %rax           # imm = 0x8000
               	shlq	$0x10, %rax
               	movq	%rcx, %rdx
               	shrq	$0xa, %rdx
               	andq	$0x1f, %rdx
               	andq	$0x3ff, %rcx            # imm = 0x3FF
               	cmpl	$0x1f, %edx
               	jne	<addr>
               	movq	%rax, %rdx
               	orq	$0x7f800000, %rdx       # imm = 0x7F800000
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	shlq	$0xd, %rax
               	orq	$0x400000, %rax         # imm = 0x400000
               	orq	%rdx, %rax
               	xorl	%edx, %edx
               	movl	%edx, -0x18(%rbp)
               	movl	%eax, -0x18(%rbp)
               	movss	-0x18(%rbp), %xmm0
               	movss	%xmm0, (%rsp)
               	movswq	%si, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rcx, %rax
               	andq	$0x8000, %rax           # imm = 0x8000
               	shlq	$0x10, %rax
               	movq	%rcx, %rsi
               	shrq	$0xa, %rsi
               	andq	$0x1f, %rsi
               	andq	$0x3ff, %rcx            # imm = 0x3FF
               	cmpl	$0x1f, %esi
               	jne	<addr>
               	orq	$0x7f800000, %rax       # imm = 0x7F800000
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rdx
               	shlq	$0xd, %rdx
               	orq	$0x400000, %rdx         # imm = 0x400000
               	orq	%rdx, %rax
               	xorl	%edx, %edx
               	movl	%edx, -0x18(%rbp)
               	movl	%eax, -0x18(%rbp)
               	movss	-0x18(%rbp), %xmm0
               	movss	%xmm0, 0x4(%rsp)
               	movswq	%di, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rcx, %rax
               	andq	$0x8000, %rax           # imm = 0x8000
               	shlq	$0x10, %rax
               	movq	%rcx, %rsi
               	shrq	$0xa, %rsi
               	andq	$0x1f, %rsi
               	andq	$0x3ff, %rcx            # imm = 0x3FF
               	cmpl	$0x1f, %esi
               	jne	<addr>
               	movq	%rax, %rsi
               	orq	$0x7f800000, %rsi       # imm = 0x7F800000
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	shlq	$0xd, %rax
               	orq	$0x400000, %rax         # imm = 0x400000
               	orq	%rsi, %rax
               	movl	%edx, -0x18(%rbp)
               	movl	%eax, -0x18(%rbp)
               	movss	-0x18(%rbp), %xmm0
               	movss	%xmm0, 0x8(%rsp)
               	movswq	%r8w, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rcx
               	andq	$0x8000, %rcx           # imm = 0x8000
               	shlq	$0x10, %rcx
               	movq	%rax, %rdx
               	shrq	$0xa, %rdx
               	andq	$0x1f, %rdx
               	andq	$0x3ff, %rax            # imm = 0x3FF
               	cmpl	$0x1f, %edx
               	jne	<addr>
               	movq	%rcx, %rdx
               	orq	$0x7f800000, %rdx       # imm = 0x7F800000
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %rcx
               	shlq	$0xd, %rcx
               	orq	$0x400000, %rcx         # imm = 0x400000
               	orq	%rdx, %rcx
               	xorl	%eax, %eax
               	movl	%eax, -0x18(%rbp)
               	movl	%ecx, -0x18(%rbp)
               	movss	-0x18(%rbp), %xmm0
               	movss	%xmm0, 0xc(%rsp)
               	movups	(%rsp), %xmm0
               	movups	%xmm0, (%rsp)
               	leaq	0x20(%rsp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	movss	(%rdx), %xmm1
               	leaq	0x1(%rax), %rdx
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rdx, %xmm0
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	jne	<addr>
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	(%rsp), %rdx
               	addq	%rdx, %rcx
               	movss	(%rcx), %xmm1
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x80(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x4, %eax
               	leaq	-0x80(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1f, %edx
               	bsrl	%eax, %esi
               	xorl	$0x1f, %esi
               	subq	%rsi, %rdx
               	leaq	0x67(%rdx), %rsi
               	shlq	$0x17, %rsi
               	orq	%rsi, %rcx
               	movl	$0x17, %esi
               	subq	%rdx, %rsi
               	shlxq	%rsi, %rax, %rax
               	andq	$0x7fffff, %rax         # imm = 0x7FFFFF
               	orq	%rax, %rcx
               	jmp	<addr>
               	addq	$0x70, %rdx
               	shlq	$0x17, %rdx
               	orq	%rdx, %rcx
               	shlq	$0xd, %rax
               	orq	%rax, %rcx
               	jmp	<addr>
               	movq	%rdx, %rax
               	jmp	<addr>
               	testl	%esi, %esi
               	jne	<addr>
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x1f, %esi
               	bsrl	%ecx, %edi
               	xorl	$0x1f, %edi
               	subq	%rdi, %rsi
               	leaq	0x67(%rsi), %rdi
               	shlq	$0x17, %rdi
               	orq	%rdi, %rax
               	movl	$0x17, %edi
               	subq	%rsi, %rdi
               	shlxq	%rdi, %rcx, %rcx
               	andq	$0x7fffff, %rcx         # imm = 0x7FFFFF
               	orq	%rcx, %rax
               	jmp	<addr>
               	addq	$0x70, %rsi
               	shlq	$0x17, %rsi
               	orq	%rsi, %rax
               	shlq	$0xd, %rcx
               	orq	%rcx, %rax
               	jmp	<addr>
               	testl	%esi, %esi
               	jne	<addr>
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x1f, %edx
               	bsrl	%ecx, %esi
               	xorl	$0x1f, %esi
               	subq	%rsi, %rdx
               	leaq	0x67(%rdx), %rsi
               	shlq	$0x17, %rsi
               	orq	%rsi, %rax
               	movl	$0x17, %esi
               	subq	%rdx, %rsi
               	shlxq	%rsi, %rcx, %rcx
               	andq	$0x7fffff, %rcx         # imm = 0x7FFFFF
               	orq	%rcx, %rax
               	jmp	<addr>
               	leaq	0x70(%rsi), %rdx
               	shlq	$0x17, %rdx
               	orq	%rdx, %rax
               	shlq	$0xd, %rcx
               	orq	%rcx, %rax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x1f, %edx
               	bsrl	%ecx, %r9d
               	xorl	$0x1f, %r9d
               	subq	%r9, %rdx
               	leaq	0x67(%rdx), %r9
               	shlq	$0x17, %r9
               	orq	%r9, %rax
               	movl	$0x17, %r9d
               	subq	%rdx, %r9
               	shlxq	%r9, %rcx, %rcx
               	andq	$0x7fffff, %rcx         # imm = 0x7FFFFF
               	orq	%rcx, %rax
               	jmp	<addr>
               	addq	$0x70, %rdx
               	shlq	$0x17, %rdx
               	orq	%rdx, %rax
               	shlq	$0xd, %rcx
               	orq	%rcx, %rax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x1f, %edx
               	bsrl	%ecx, %esi
               	xorl	$0x1f, %esi
               	subq	%rsi, %rdx
               	leaq	0x67(%rdx), %rsi
               	shlq	$0x17, %rsi
               	orq	%rsi, %rax
               	movl	$0x17, %esi
               	subq	%rdx, %rsi
               	shlxq	%rsi, %rcx, %rcx
               	andq	$0x7fffff, %rcx         # imm = 0x7FFFFF
               	orq	%rcx, %rax
               	jmp	<addr>
               	addq	$0x70, %rdx
               	shlq	$0x17, %rdx
               	orq	%rdx, %rax
               	shlq	$0xd, %rcx
               	orq	%rcx, %rax
               	jmp	<addr>
               	movq	%rdx, %rax
               	jmp	<addr>
               	testl	%esi, %esi
               	jne	<addr>
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x1f, %esi
               	bsrl	%ecx, %edi
               	xorl	$0x1f, %edi
               	subq	%rdi, %rsi
               	leaq	0x67(%rsi), %rdi
               	shlq	$0x17, %rdi
               	orq	%rdi, %rax
               	movl	$0x17, %edi
               	subq	%rsi, %rdi
               	shlxq	%rdi, %rcx, %rcx
               	andq	$0x7fffff, %rcx         # imm = 0x7FFFFF
               	orq	%rcx, %rax
               	jmp	<addr>
               	addq	$0x70, %rsi
               	shlq	$0x17, %rsi
               	orq	%rsi, %rax
               	shlq	$0xd, %rcx
               	orq	%rcx, %rax
               	jmp	<addr>
               	testl	%esi, %esi
               	jne	<addr>
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x1f, %edx
               	bsrl	%ecx, %esi
               	xorl	$0x1f, %esi
               	subq	%rsi, %rdx
               	leaq	0x67(%rdx), %rsi
               	shlq	$0x17, %rsi
               	orq	%rsi, %rax
               	movl	$0x17, %esi
               	subq	%rdx, %rsi
               	shlxq	%rsi, %rcx, %rcx
               	andq	$0x7fffff, %rcx         # imm = 0x7FFFFF
               	orq	%rcx, %rax
               	jmp	<addr>
               	leaq	0x70(%rsi), %rdx
               	shlq	$0x17, %rdx
               	orq	%rdx, %rax
               	shlq	$0xd, %rcx
               	orq	%rcx, %rax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x1f, %edx
               	bsrl	%ecx, %esi
               	xorl	$0x1f, %esi
               	subq	%rsi, %rdx
               	leaq	0x67(%rdx), %rsi
               	shlq	$0x17, %rsi
               	orq	%rsi, %rax
               	movl	$0x17, %esi
               	subq	%rdx, %rsi
               	shlxq	%rsi, %rcx, %rcx
               	andq	$0x7fffff, %rcx         # imm = 0x7FFFFF
               	orq	%rcx, %rax
               	jmp	<addr>
               	addq	$0x70, %rdx
               	shlq	$0x17, %rdx
               	orq	%rdx, %rax
               	shlq	$0xd, %rcx
               	orq	%rcx, %rax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x1f, %edx
               	bsrl	%ecx, %esi
               	xorl	$0x1f, %esi
               	subq	%rsi, %rdx
               	leaq	0x67(%rdx), %rsi
               	shlq	$0x17, %rsi
               	orq	%rsi, %rax
               	movl	$0x17, %esi
               	subq	%rdx, %rsi
               	shlxq	%rsi, %rcx, %rcx
               	andq	$0x7fffff, %rcx         # imm = 0x7FFFFF
               	orq	%rcx, %rax
               	jmp	<addr>
               	addq	$0x70, %rdx
               	shlq	$0x17, %rdx
               	orq	%rdx, %rax
               	shlq	$0xd, %rcx
               	orq	%rcx, %rax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x1f, %edx
               	bsrl	%ecx, %esi
               	xorl	$0x1f, %esi
               	subq	%rsi, %rdx
               	leaq	0x67(%rdx), %rsi
               	shlq	$0x17, %rsi
               	orq	%rsi, %rax
               	movl	$0x17, %esi
               	subq	%rdx, %rsi
               	shlxq	%rsi, %rcx, %rcx
               	andq	$0x7fffff, %rcx         # imm = 0x7FFFFF
               	orq	%rcx, %rax
               	jmp	<addr>
               	addq	$0x70, %rdx
               	shlq	$0x17, %rdx
               	orq	%rdx, %rax
               	shlq	$0xd, %rcx
               	orq	%rcx, %rax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x1f, %edx
               	bsrl	%ecx, %esi
               	xorl	$0x1f, %esi
               	subq	%rsi, %rdx
               	leaq	0x67(%rdx), %rsi
               	shlq	$0x17, %rsi
               	orq	%rsi, %rax
               	movl	$0x17, %esi
               	subq	%rdx, %rsi
               	shlxq	%rsi, %rcx, %rcx
               	andq	$0x7fffff, %rcx         # imm = 0x7FFFFF
               	orq	%rcx, %rax
               	jmp	<addr>
               	addq	$0x70, %rdx
               	shlq	$0x17, %rdx
               	orq	%rdx, %rax
               	shlq	$0xd, %rcx
               	orq	%rcx, %rax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x1f, %edx
               	bsrl	%ecx, %r14d
               	xorl	$0x1f, %r14d
               	subq	%r14, %rdx
               	leaq	0x67(%rdx), %r14
               	shlq	$0x17, %r14
               	orq	%r14, %rax
               	movl	$0x17, %r14d
               	subq	%rdx, %r14
               	shlxq	%r14, %rcx, %rcx
               	andq	$0x7fffff, %rcx         # imm = 0x7FFFFF
               	orq	%rcx, %rax
               	jmp	<addr>
               	addq	$0x70, %rdx
               	shlq	$0x17, %rdx
               	orq	%rdx, %rax
               	shlq	$0xd, %rcx
               	orq	%rcx, %rax
               	jmp	<addr>
               	movl	$0x3, %eax
               	leaq	-0x80(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x2, %eax
               	leaq	-0x80(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x1, %eax
               	leaq	-0x80(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
