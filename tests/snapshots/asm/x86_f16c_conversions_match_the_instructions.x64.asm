
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
               	subq	$0x20, %rsp
               	movq	%rsi, 0x18(%rsp)
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
               	leave
               	retq
               	testl	$0x400000, %edi         # imm = 0x400000
               	jne	<addr>
               	orl	$0x1, (%rcx)
               	orq	$0x7e00, %rax           # imm = 0x7E00
               	movq	%rdi, %rcx
               	shrq	$0xd, %rcx
               	orq	%rcx, %rax
               	leave
               	retq
               	testl	%r8d, %r8d
               	jne	<addr>
               	testl	%edi, %edi
               	je	<addr>
               	testb	$0x40, %dl
               	je	<addr>
               	leave
               	retq
               	orl	$0x2, (%rcx)
               	movq	%rdi, %rdx
               	orq	$0x800000, %rdx         # imm = 0x800000
               	testq	%r8, %r8
               	cmovneq	%rdx, %rdi
               	leaq	-0x96(%r8), %rsi
               	movq	$-0x95, %rdx
               	testq	%r8, %r8
               	cmoveq	%rdx, %rsi
               	leaq	0x1f(%rsi), %r8
               	movl	$0x3f, %r11d
               	bsrl	%edi, %edx
               	cmovel	%r11d, %edx
               	xorl	$0x1f, %edx
               	subq	%rdx, %r8
               	leaq	-0xa(%r8), %rdx
               	movq	$-0x18, %r9
               	cmpl	$-0xe, %r8d
               	cmovlq	%r9, %rdx
               	subq	%rsi, %rdx
               	shrxq	%rdx, %rdi, %rsi
               	xorl	%r9d, %r9d
               	cmpl	$0x20, %edx
               	movq	%r9, %r10
               	cmovlq	%rsi, %r10
               	movq	%r10, 0x10(%rsp)
               	cmpl	$0x20, %edx
               	jge	<addr>
               	movl	$0x1, %esi
               	shlxq	%rdx, %rsi, %rsi
               	leaq	-0x1(%rsi), %r9
               	andq	%rdi, %r9
               	cmpl	$0x40, %edx
               	jge	<addr>
               	movl	$0x1, %esi
               	decq	%rdx
               	shlxq	%rdx, %rsi, %rsi
               	testl	%r9d, %r9d
               	jne	<addr>
               	xorl	%edx, %edx
               	movq	0x10(%rsp), %rsi
               	addq	%rdx, %rsi
               	cmpl	$-0xe, %r8d
               	jl	<addr>
               	leaq	0xf(%r8), %rdx
               	shlq	$0xa, %rdx
               	addq	%rsi, %rdx
               	leaq	-0x400(%rdx), %rsi
               	cmpl	$0x7c00, %esi           # imm = 0x7C00
               	jb	<addr>
               	orl	$0x28, (%rcx)
               	movq	0x18(%rsp), %rdx
               	andq	$0x3, %rdx
               	movl	$0x1, %ecx
               	testl	%edx, %edx
               	je	<addr>
               	xorl	%esi, %esi
               	testl	%eax, %eax
               	setne	%dil
               	movzbq	%dil, %rdi
               	cmpl	$0x1, %edx
               	cmoveq	%rdi, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	xorl	%ecx, %ecx
               	testl	%eax, %eax
               	sete	%sil
               	movzbq	%sil, %rsi
               	cmpl	$0x2, %edx
               	cmoveq	%rsi, %rcx
               	movl	$0x7c00, %edx           # imm = 0x7C00
               	movl	$0x7bff, %esi           # imm = 0x7BFF
               	testq	%rcx, %rcx
               	cmoveq	%rsi, %rdx
               	orq	%rdx, %rax
               	leave
               	retq
               	movq	%rcx, %rsi
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
               	movl	$0x10, %r8d
               	xorl	%r9d, %r9d
               	testq	%rdx, %rdx
               	cmoveq	%r9, %r8
               	orq	$0x20, %r8
               	orq	%r8, %rdi
               	movl	%edi, (%rcx)
               	orq	%rsi, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	leave
               	retq
               	movq	0x18(%rsp), %rdx
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
               	xorl	%edx, %edx
               	movq	%r9, %r10
               	andq	$0x1, %r10
               	movq	%r10, 0x18(%rsp)
               	testl	%r10d, %r10d
               	setne	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x18(%rsp)
               	cmpl	%r8d, %edi
               	movq	0x18(%rsp), %r10
               	cmoveq	%r10, %rdx
               	jmp	<addr>
               	movq	0x18(%rsp), %rdx
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
               	cmpq	%rsi, %r9
               	movl	$0x1, %edx
               	ja	<addr>
               	xorl	%edx, %edx
               	movq	0x10(%rsp), %r10
               	andq	$0x1, %r10
               	movq	%r10, 0x8(%rsp)
               	testl	%r10d, %r10d
               	setne	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x8(%rsp)
               	cmpq	%rsi, %r9
               	movq	0x8(%rsp), %r10
               	cmoveq	%r10, %rdx
               	jmp	<addr>
               	movq	$-0x1, %rsi
               	jmp	<addr>
               	movq	%rdi, %r9
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x40, %rsp
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
               	movss	%xmm0, -0x18(%rbp)
               	movl	-0x18(%rbp), %edi
               	leaq	-0x38(%rbp), %rcx
               	movq	%r12, %rsi
               	movq	%rbx, %rdx
               	vzeroupper
               	callq	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x48(%rbp)
               	movl	$0x1, %eax
               	cmpl	$0x1, %eax
               	jl	<addr>
               	movl	-0x38(%rbp), %eax
               	testq	%rax, %rax
               	je	<addr>
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
               	movss	%xmm0, -0x18(%rbp)
               	movl	-0x18(%rbp), %edi
               	movl	$0x3, %esi
               	leaq	-0x38(%rbp), %rcx
               	movq	%rbx, %rdx
               	vzeroupper
               	callq	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x48(%rbp)
               	movl	$0x1, %eax
               	cmpl	$0x1, %eax
               	jl	<addr>
               	movl	-0x38(%rbp), %eax
               	testq	%rax, %rax
               	je	<addr>
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
               	movss	%xmm0, -0x18(%rbp)
               	movl	-0x18(%rbp), %edi
               	movl	$0x2, %esi
               	leaq	-0x38(%rbp), %rcx
               	movq	%rbx, %rdx
               	vzeroupper
               	callq	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x48(%rbp)
               	movl	$0x1, %eax
               	cmpl	$0x1, %eax
               	jl	<addr>
               	movl	-0x38(%rbp), %eax
               	testq	%rax, %rax
               	je	<addr>
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
               	movss	%xmm0, -0x18(%rbp)
               	movl	-0x18(%rbp), %edi
               	movl	$0x1, %esi
               	leaq	-0x38(%rbp), %rcx
               	movq	%rbx, %rdx
               	vzeroupper
               	callq	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x48(%rbp)
               	movl	$0x1, %eax
               	cmpl	$0x1, %eax
               	jl	<addr>
               	movl	-0x38(%rbp), %eax
               	testq	%rax, %rax
               	je	<addr>
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
               	movss	%xmm0, -0x18(%rbp)
               	movl	-0x18(%rbp), %edi
               	xorl	%esi, %esi
               	leaq	-0x38(%rbp), %rcx
               	movq	%rbx, %rdx
               	vzeroupper
               	callq	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x48(%rbp)
               	movl	$0x1, %eax
               	cmpl	$0x1, %eax
               	jl	<addr>
               	movl	-0x38(%rbp), %eax
               	testq	%rax, %rax
               	je	<addr>
               	orq	%rbx, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movzwq	-0x48(%rbp), %rcx
               	jmp	<addr>
               	incq	%r13
               	cmpl	$0x54, %r13d
               	jb	<addr>
               	movl	$0x0, -0x18(%rbp)
               	movl	$0x33800000, -0x58(%rbp) # imm = 0x33800000
               	movss	-0x58(%rbp), %xmm0
               	movss	%xmm0, -0x60(%rbp)
               	movl	-0x60(%rbp), %ecx
               	cmpl	$0x33800000, %ecx       # imm = 0x33800000
               	je	<addr>
               	movl	$0x2, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	vzeroupper
               	leave
               	retq
               	movl	$0x0, -0x18(%rbp)
               	movl	$0x387fc000, -0x58(%rbp) # imm = 0x387FC000
               	movss	-0x58(%rbp), %xmm0
               	movss	%xmm0, -0x60(%rbp)
               	movl	-0x60(%rbp), %ecx
               	cmpl	$0x387fc000, %ecx       # imm = 0x387FC000
               	jne	<addr>
               	movl	$0x0, -0x18(%rbp)
               	movl	$0x38800000, -0x58(%rbp) # imm = 0x38800000
               	movss	-0x58(%rbp), %xmm0
               	movss	%xmm0, -0x60(%rbp)
               	movl	-0x60(%rbp), %eax
               	cmpl	$0x38800000, %eax       # imm = 0x38800000
               	jne	<addr>
               	movl	$0x0, -0x18(%rbp)
               	movl	$0x3f800000, -0x58(%rbp) # imm = 0x3F800000
               	movss	-0x58(%rbp), %xmm0
               	movss	%xmm0, -0x60(%rbp)
               	movl	-0x60(%rbp), %ecx
               	cmpl	$0x3f800000, %ecx       # imm = 0x3F800000
               	jne	<addr>
               	movl	$0x0, -0x18(%rbp)
               	movl	$0x477fe000, -0x58(%rbp) # imm = 0x477FE000
               	movss	-0x58(%rbp), %xmm0
               	movss	%xmm0, -0x60(%rbp)
               	movl	-0x60(%rbp), %ecx
               	cmpl	$0x477fe000, %ecx       # imm = 0x477FE000
               	jne	<addr>
               	movl	$0x0, -0x18(%rbp)
               	movl	$0xc77fe000, -0x58(%rbp) # imm = 0xC77FE000
               	movss	-0x58(%rbp), %xmm0
               	movss	%xmm0, -0x60(%rbp)
               	movl	-0x60(%rbp), %eax
               	cmpl	$0xc77fe000, %eax       # imm = 0xC77FE000
               	jne	<addr>
               	movl	$0x0, -0x18(%rbp)
               	movl	$0x7f800000, -0x58(%rbp) # imm = 0x7F800000
               	movss	-0x58(%rbp), %xmm0
               	movss	%xmm0, -0x60(%rbp)
               	movl	-0x60(%rbp), %ecx
               	cmpl	$0x7f800000, %ecx       # imm = 0x7F800000
               	jne	<addr>
               	movl	$0x0, -0x18(%rbp)
               	movl	$0x7fc02000, -0x58(%rbp) # imm = 0x7FC02000
               	movss	-0x58(%rbp), %xmm0
               	movss	%xmm0, -0x60(%rbp)
               	movl	-0x60(%rbp), %ecx
               	cmpl	$0x7fc02000, %ecx       # imm = 0x7FC02000
               	jne	<addr>
               	movl	$0x0, -0x18(%rbp)
               	movl	$0xffc02000, -0x58(%rbp) # imm = 0xFFC02000
               	movss	-0x58(%rbp), %xmm0
               	movss	%xmm0, -0x60(%rbp)
               	movl	-0x60(%rbp), %eax
               	cmpl	$0xffc02000, %eax       # imm = 0xFFC02000
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	vmovups	(%rax), %ymm1
               	leaq	-0x30(%rbp), %r13
               	vmovups	%ymm1, -0x30(%rbp)
               	leaq	-0x58(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x58(%rbp), %r12d
               	xorl	%ebx, %ebx
               	movl	%ebx, -0x48(%rbp)
               	movq	%rbx, %rax
               	shlq	$0x2, %rax
               	addq	%r13, %rax
               	movss	(%rax), %xmm0
               	movss	%xmm0, -0x50(%rbp)
               	movl	-0x50(%rbp), %edi
               	xorl	%esi, %esi
               	leaq	-0x48(%rbp), %rcx
               	vmovups	%ymm1, -0x80(%rbp)
               	movq	%r12, %rdx
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x80(%rbp), %ymm1
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x40(%rbp,%rbx,2)
               	incq	%rbx
               	cmpl	$0x8, %ebx
               	jl	<addr>
               	movl	-0x48(%rbp), %eax
               	testq	%rax, %rax
               	je	<addr>
               	orq	%r12, %rax
               	movl	%eax, -0x58(%rbp)
               	leaq	-0x58(%rbp), %rax
               	ldmxcsr	(%rax)
               	leaq	-0x40(%rbp), %r14
               	movups	-0x40(%rbp), %xmm0
               	vpermilps	$0x0, %xmm1, %xmm2 # xmm2 = xmm1[0,0,0,0]
               	movss	%xmm2, -0x40(%rbp)
               	vpermilps	$0x1, %xmm1, %xmm2 # xmm2 = xmm1[1,0,0,0]
               	movss	%xmm2, -0x3c(%rbp)
               	vpermilps	$0x2, %xmm1, %xmm2 # xmm2 = xmm1[2,0,0,0]
               	movss	%xmm2, -0x38(%rbp)
               	vpermilps	$0x3, %xmm1, %xmm1 # xmm1 = xmm1[3,0,0,0]
               	movss	%xmm1, -0x34(%rbp)
               	leaq	-0x20(%rbp), %r12
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%r12)
               	leaq	-0x58(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x58(%rbp), %r13d
               	xorl	%ebx, %ebx
               	movl	%ebx, -0x48(%rbp)
               	movq	%rbx, %rax
               	shlq	$0x2, %rax
               	addq	%r14, %rax
               	movss	(%rax), %xmm1
               	movss	%xmm1, -0x50(%rbp)
               	movl	-0x50(%rbp), %edi
               	xorl	%esi, %esi
               	leaq	-0x48(%rbp), %rcx
               	movups	%xmm0, -0x90(%rbp)
               	movq	%r13, %rdx
               	vzeroupper
               	callq	<addr>
               	movups	-0x90(%rbp), %xmm0
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x20(%rbp,%rbx,2)
               	incq	%rbx
               	cmpl	$0x4, %ebx
               	jl	<addr>
               	movl	-0x48(%rbp), %eax
               	testq	%rax, %rax
               	je	<addr>
               	orq	%r13, %rax
               	movl	%eax, -0x58(%rbp)
               	leaq	-0x58(%rbp), %rax
               	ldmxcsr	(%rax)
               	movups	-0x20(%rbp), %xmm1
               	movups	%xmm0, -0x20(%rbp)
               	movups	%xmm1, -0x30(%rbp)
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx # <addr>
               	leaq	-0x20(%rbp), %rsi
               	movq	%rax, %rcx
               	shlq	%rcx
               	addq	%rcx, %rsi
               	movzwq	(%rsi), %rsi
               	addq	%rdx, %rcx
               	movzwq	(%rcx), %rcx
               	cmpl	%ecx, %esi
               	jne	<addr>
               	movzwq	-0x30(%rbp,%rax,2), %rsi
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
               	vpextrw	$0x0, %xmm0, %ecx
               	movswq	%cx, %rcx
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
               	orq	$0x7f800000, %rax       # imm = 0x7F800000
               	movq	%rcx, %rdx
               	shlq	$0xd, %rdx
               	orq	$0x400000, %rdx         # imm = 0x400000
               	xorl	%esi, %esi
               	testq	%rcx, %rcx
               	cmoveq	%rsi, %rdx
               	orq	%rdx, %rax
               	movl	%eax, -0x18(%rbp)
               	movss	-0x18(%rbp), %xmm1
               	vmovd	%xmm1, %r11d
               	vmovd	%r11d, %xmm1
               	vpextrw	$0x1, %xmm0, %ecx
               	movswq	%cx, %rcx
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
               	orq	$0x7f800000, %rax       # imm = 0x7F800000
               	movq	%rcx, %rdx
               	shlq	$0xd, %rdx
               	orq	$0x400000, %rdx         # imm = 0x400000
               	xorl	%edi, %edi
               	testq	%rcx, %rcx
               	cmoveq	%rdi, %rdx
               	orq	%rdx, %rax
               	movl	%eax, -0x18(%rbp)
               	movss	-0x18(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x1, %r11d, %xmm1, %xmm1
               	vpextrw	$0x2, %xmm0, %ecx
               	movswq	%cx, %rcx
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
               	orq	$0x7f800000, %rax       # imm = 0x7F800000
               	movq	%rcx, %rdx
               	shlq	$0xd, %rdx
               	orq	$0x400000, %rdx         # imm = 0x400000
               	xorl	%edi, %edi
               	testq	%rcx, %rcx
               	cmoveq	%rdi, %rdx
               	orq	%rdx, %rax
               	movl	%eax, -0x18(%rbp)
               	movss	-0x18(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x2, %r11d, %xmm1, %xmm1
               	vpextrw	$0x3, %xmm0, %ecx
               	movswq	%cx, %rcx
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
               	orq	$0x7f800000, %rax       # imm = 0x7F800000
               	movq	%rcx, %rdx
               	shlq	$0xd, %rdx
               	orq	$0x400000, %rdx         # imm = 0x400000
               	xorl	%edi, %edi
               	testq	%rcx, %rcx
               	cmoveq	%rdi, %rdx
               	orq	%rdx, %rax
               	movl	%eax, -0x18(%rbp)
               	movss	-0x18(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x3, %r11d, %xmm1, %xmm1
               	vpextrw	$0x4, %xmm0, %ecx
               	movswq	%cx, %rcx
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
               	orq	$0x7f800000, %rax       # imm = 0x7F800000
               	movq	%rcx, %rdx
               	shlq	$0xd, %rdx
               	orq	$0x400000, %rdx         # imm = 0x400000
               	xorl	%esi, %esi
               	testq	%rcx, %rcx
               	cmoveq	%rsi, %rdx
               	orq	%rdx, %rax
               	movl	%eax, -0x18(%rbp)
               	movss	-0x18(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vmovd	%r11d, %xmm2
               	vpextrw	$0x5, %xmm0, %ecx
               	movswq	%cx, %rcx
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
               	orq	$0x7f800000, %rax       # imm = 0x7F800000
               	movq	%rcx, %rdx
               	shlq	$0xd, %rdx
               	orq	$0x400000, %rdx         # imm = 0x400000
               	xorl	%esi, %esi
               	testq	%rcx, %rcx
               	cmoveq	%rsi, %rdx
               	orq	%rdx, %rax
               	movl	%eax, -0x18(%rbp)
               	movss	-0x18(%rbp), %xmm3
               	vmovd	%xmm3, %r11d
               	vpinsrd	$0x1, %r11d, %xmm2, %xmm2
               	vpextrw	$0x6, %xmm0, %ecx
               	movswq	%cx, %rcx
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
               	orq	$0x7f800000, %rax       # imm = 0x7F800000
               	movq	%rcx, %rdx
               	shlq	$0xd, %rdx
               	orq	$0x400000, %rdx         # imm = 0x400000
               	xorl	%esi, %esi
               	testq	%rcx, %rcx
               	cmoveq	%rsi, %rdx
               	orq	%rdx, %rax
               	movl	%eax, -0x18(%rbp)
               	movss	-0x18(%rbp), %xmm3
               	vmovd	%xmm3, %r11d
               	vpinsrd	$0x2, %r11d, %xmm2, %xmm2
               	vpextrw	$0x7, %xmm0, %ecx
               	movswq	%cx, %rcx
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
               	orq	$0x7f800000, %rax       # imm = 0x7F800000
               	movq	%rcx, %rdx
               	shlq	$0xd, %rdx
               	orq	$0x400000, %rdx         # imm = 0x400000
               	xorl	%esi, %esi
               	testq	%rcx, %rcx
               	cmoveq	%rsi, %rdx
               	orq	%rdx, %rax
               	movl	%eax, -0x18(%rbp)
               	movss	-0x18(%rbp), %xmm3
               	vmovd	%xmm3, %r11d
               	vpinsrd	$0x3, %r11d, %xmm2, %xmm2
               	vinserti128	$0x1, %xmm2, %ymm1, %ymm1
               	vmovups	%ymm1, (%rsp)
               	vpextrw	$0x0, %xmm0, %ecx
               	movswq	%cx, %rcx
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
               	orq	$0x7f800000, %rax       # imm = 0x7F800000
               	movq	%rcx, %rdx
               	shlq	$0xd, %rdx
               	orq	$0x400000, %rdx         # imm = 0x400000
               	xorl	%esi, %esi
               	testq	%rcx, %rcx
               	cmoveq	%rsi, %rdx
               	orq	%rdx, %rax
               	movl	%eax, -0x18(%rbp)
               	movss	-0x18(%rbp), %xmm1
               	vmovd	%xmm1, %r11d
               	vmovd	%r11d, %xmm1
               	vpextrw	$0x1, %xmm0, %ecx
               	movswq	%cx, %rcx
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
               	orq	$0x7f800000, %rax       # imm = 0x7F800000
               	movq	%rcx, %rdx
               	shlq	$0xd, %rdx
               	orq	$0x400000, %rdx         # imm = 0x400000
               	xorl	%esi, %esi
               	testq	%rcx, %rcx
               	cmoveq	%rsi, %rdx
               	orq	%rdx, %rax
               	movl	%eax, -0x18(%rbp)
               	movss	-0x18(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x1, %r11d, %xmm1, %xmm1
               	vpextrw	$0x2, %xmm0, %ecx
               	movswq	%cx, %rcx
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
               	orq	$0x7f800000, %rax       # imm = 0x7F800000
               	movq	%rcx, %rdx
               	shlq	$0xd, %rdx
               	orq	$0x400000, %rdx         # imm = 0x400000
               	xorl	%esi, %esi
               	testq	%rcx, %rcx
               	cmoveq	%rsi, %rdx
               	orq	%rdx, %rax
               	movl	%eax, -0x18(%rbp)
               	movss	-0x18(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x2, %r11d, %xmm1, %xmm1
               	vpextrw	$0x3, %xmm0, %ecx
               	movswq	%cx, %rcx
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
               	orq	$0x7f800000, %rax       # imm = 0x7F800000
               	movq	%rcx, %rdx
               	shlq	$0xd, %rdx
               	orq	$0x400000, %rdx         # imm = 0x400000
               	xorl	%esi, %esi
               	testq	%rcx, %rcx
               	cmoveq	%rsi, %rdx
               	orq	%rdx, %rax
               	movl	%eax, -0x18(%rbp)
               	movss	-0x18(%rbp), %xmm0
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	leaq	(%rsp), %rdx
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
               	leaq	0x20(%rsp), %rdx
               	addq	%rdx, %rcx
               	movss	(%rcx), %xmm1
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	vzeroupper
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	vzeroupper
               	leave
               	retq
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
               	testl	%edx, %edx
               	jne	<addr>
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x1f, %edx
               	bsrl	%ecx, %edi
               	xorl	$0x1f, %edi
               	subq	%rdi, %rdx
               	leaq	0x67(%rdx), %rdi
               	shlq	$0x17, %rdi
               	orq	%rdi, %rax
               	movl	$0x17, %edi
               	subq	%rdx, %rdi
               	shlxq	%rdi, %rcx, %rcx
               	andq	$0x7fffff, %rcx         # imm = 0x7FFFFF
               	orq	%rcx, %rax
               	jmp	<addr>
               	addq	$0x70, %rdx
               	shlq	$0x17, %rdx
               	orq	%rdx, %rax
               	shlq	$0xd, %rcx
               	orq	%rcx, %rax
               	jmp	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x1f, %edx
               	bsrl	%ecx, %edi
               	xorl	$0x1f, %edi
               	subq	%rdi, %rdx
               	leaq	0x67(%rdx), %rdi
               	shlq	$0x17, %rdi
               	orq	%rdi, %rax
               	movl	$0x17, %edi
               	subq	%rdx, %rdi
               	shlxq	%rdi, %rcx, %rcx
               	andq	$0x7fffff, %rcx         # imm = 0x7FFFFF
               	orq	%rcx, %rax
               	jmp	<addr>
               	addq	$0x70, %rdx
               	shlq	$0x17, %rdx
               	orq	%rdx, %rax
               	shlq	$0xd, %rcx
               	orq	%rcx, %rax
               	jmp	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x1f, %edx
               	bsrl	%ecx, %edi
               	xorl	$0x1f, %edi
               	subq	%rdi, %rdx
               	leaq	0x67(%rdx), %rdi
               	shlq	$0x17, %rdi
               	orq	%rdi, %rax
               	movl	$0x17, %edi
               	subq	%rdx, %rdi
               	shlxq	%rdi, %rcx, %rcx
               	andq	$0x7fffff, %rcx         # imm = 0x7FFFFF
               	orq	%rcx, %rax
               	jmp	<addr>
               	addq	$0x70, %rdx
               	shlq	$0x17, %rdx
               	orq	%rdx, %rax
               	shlq	$0xd, %rcx
               	orq	%rcx, %rax
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
               	movl	$0x3, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	vzeroupper
               	leave
               	retq
               	movl	$0x1, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	vzeroupper
               	leave
               	retq
