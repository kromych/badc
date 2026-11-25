
x86_f16c_conversions_match_the_instructions.x64:	file format elf64-x86-64

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

<__badc_f32_to_f16>:
               	subq	$0x20, %rsp
               	pushq	%rbx
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
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
               	testl	$0x400000, %edi         # imm = 0x400000
               	jne	<addr>
               	orl	$0x1, (%rcx)
               	orq	$0x7e00, %rax           # imm = 0x7E00
               	movq	%rdi, %rcx
               	shrq	$0xd, %rcx
               	orq	%rcx, %rax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
               	testl	%r8d, %r8d
               	jne	<addr>
               	testl	%edi, %edi
               	je	<addr>
               	testb	$0x40, %dl
               	je	<addr>
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
               	orl	$0x2, (%rcx)
               	movq	%rdi, %r9
               	orq	$0x800000, %r9          # imm = 0x800000
               	testq	%r8, %r8
               	cmoveq	%rdi, %r9
               	leaq	-0x96(%r8), %rsi
               	movq	$-0x95, %rdx
               	testq	%r8, %r8
               	cmoveq	%rdx, %rsi
               	leaq	0x1f(%rsi), %rdi
               	movl	$0x3f, %r11d
               	bsrl	%r9d, %edx
               	cmovel	%r11d, %edx
               	xorl	$0x1f, %edx
               	subq	%rdx, %rdi
               	leaq	-0xa(%rdi), %rdx
               	movq	$-0x18, %r8
               	cmpl	$-0xe, %edi
               	cmovlq	%r8, %rdx
               	subq	%rsi, %rdx
               	shrxq	%rdx, %r9, %rbx
               	xorl	%esi, %esi
               	cmpl	$0x20, %edx
               	cmovgeq	%rsi, %rbx
               	cmpl	$0x20, %edx
               	jge	<addr>
               	movl	$0x1, %esi
               	shlxq	%rdx, %rsi, %rsi
               	leaq	-0x1(%rsi), %r8
               	andq	%r9, %r8
               	cmpl	$0x40, %edx
               	jge	<addr>
               	movl	$0x1, %esi
               	decq	%rdx
               	shlxq	%rdx, %rsi, %rsi
               	testl	%r8d, %r8d
               	jne	<addr>
               	xorl	%edx, %edx
               	addq	%rbx, %rdx
               	cmpl	$-0xe, %edi
               	jl	<addr>
               	leaq	0xf(%rdi), %rsi
               	shlq	$0xa, %rsi
               	addq	%rsi, %rdx
               	subq	$0x400, %rdx            # imm = 0x400
               	cmpl	$0x7c00, %edx           # imm = 0x7C00
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
               	movq	%rsi, %rcx
               	cmovneq	%rdx, %rcx
               	orq	%rax, %rcx
               	movq	%rcx, %rax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
               	movq	%rcx, %rsi
               	jmp	<addr>
               	testq	%r8, %r8
               	je	<addr>
               	movq	%r9, %rbx
               	shrq	$0xd, %rbx
               	cmpl	$-0xf, %edi
               	movl	$0x1, %r8d
               	jl	<addr>
               	cmpl	$-0xf, %edi
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorl	%r8d, %r8d
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%r9, %rdi
               	andq	$0x1fff, %rdi           # imm = 0x1FFF
               	movl	$0x1000, %r8d           # imm = 0x1000
               	testl	%edi, %edi
               	jne	<addr>
               	xorl	%esi, %esi
               	addq	%rbx, %rsi
               	cmpl	$0x800, %esi            # imm = 0x800
               	setb	%r8b
               	movzbq	%r8b, %r8
               	movl	(%rcx), %edi
               	movl	$0x10, %esi
               	xorl	%r9d, %r9d
               	testq	%r8, %r8
               	cmoveq	%r9, %rsi
               	orq	$0x20, %rsi
               	orq	%rsi, %rdi
               	movl	%edi, (%rcx)
               	orq	%rdx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
               	movq	0x18(%rsp), %rsi
               	andq	$0x3, %rsi
               	cmpl	$0x1, %esi
               	jb	<addr>
               	cmpl	$0x2, %esi
               	jb	<addr>
               	cmpl	$0x2, %esi
               	je	<addr>
               	xorl	%esi, %esi
               	jmp	<addr>
               	testl	%eax, %eax
               	sete	%sil
               	movzbq	%sil, %rsi
               	jmp	<addr>
               	testl	%eax, %eax
               	setne	%sil
               	movzbq	%sil, %rsi
               	jmp	<addr>
               	cmpl	%r8d, %edi
               	movl	$0x1, %esi
               	ja	<addr>
               	xorl	%esi, %esi
               	movq	%rbx, %r9
               	andq	$0x1, %r9
               	testl	%r9d, %r9d
               	setne	%r9b
               	movzbq	%r9b, %r9
               	cmpl	%r8d, %edi
               	cmoveq	%r9, %rsi
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
               	cmpq	%rsi, %r8
               	movl	$0x1, %edx
               	ja	<addr>
               	xorl	%edx, %edx
               	movq	%rbx, %r10
               	andq	$0x1, %r10
               	movq	%r10, 0x10(%rsp)
               	testl	%r10d, %r10d
               	setne	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x10(%rsp)
               	cmpq	%rsi, %r8
               	movq	0x10(%rsp), %r10
               	cmoveq	%r10, %rdx
               	jmp	<addr>
               	movq	$-0x1, %rsi
               	jmp	<addr>
               	movq	%r9, %r8
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xe0, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %r14d
               	xorl	%ebx, %ebx
               	leaq	-0xb0(%rbp), %rdx
               	leaq	<rip>, %rax # <addr>
               	imulq	$0x14, %rbx, %rcx
               	addq	%rcx, %rax
               	movl	(%rax), %r10d
               	movl	%r10d, (%rdx)
               	movl	0x8(%rax), %eax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movss	-0xb0(%rbp), %xmm0
               	leaq	<rip>, %rax # <addr>
               	addq	%rcx, %rax
               	movl	0x4(%rax), %eax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	cmpl	$0x3, %eax
               	jl	<addr>
               	nopl	(%rax)
               	cmpl	$0x3, %eax
               	je	<addr>
               	movss	%xmm0, -0x68(%rbp)
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %r12d
               	xorl	%eax, %eax
               	movl	%eax, -0x58(%rbp)
               	movq	%r12, %r13
               	shrq	$0xd, %r13
               	andq	$0x3, %r13
               	movss	-0x68(%rbp), %xmm0
               	movss	%xmm0, -0x28(%rbp)
               	movl	-0x28(%rbp), %edi
               	leaq	-0x58(%rbp), %rcx
               	movq	%r13, %rsi
               	movq	%r12, %rdx
               	vzeroupper
               	callq	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x60(%rbp)
               	movl	$0x1, %eax
               	nopw	(%rax,%rax)
               	cmpl	$0x1, %eax
               	jl	<addr>
               	movl	-0x58(%rbp), %eax
               	testq	%rax, %rax
               	je	<addr>
               	orq	%r12, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movzwq	-0x60(%rbp), %rcx
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %edx
               	andq	$0x3f, %rdx
               	movl	%r14d, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	leaq	<rip>, %rax # <addr>
               	imulq	$0x14, %rbx, %rsi
               	addq	%rsi, %rax
               	movl	0xc(%rax), %eax
               	cmpl	%eax, %ecx
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	imulq	$0x14, %rbx, %rcx
               	addq	%rcx, %rax
               	movl	0x10(%rax), %eax
               	cmpl	%eax, %edx
               	je	<addr>
               	jmp	<addr>
               	movss	%xmm0, -0x78(%rbp)
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %r12d
               	xorl	%eax, %eax
               	movl	%eax, -0x58(%rbp)
               	movss	-0x78(%rbp), %xmm0
               	movss	%xmm0, -0x38(%rbp)
               	movl	-0x38(%rbp), %edi
               	movl	$0x3, %esi
               	leaq	-0x58(%rbp), %rcx
               	movq	%r12, %rdx
               	vzeroupper
               	callq	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x70(%rbp)
               	movl	$0x1, %eax
               	nopw	(%rax,%rax)
               	cmpl	$0x1, %eax
               	jl	<addr>
               	movl	-0x58(%rbp), %eax
               	testq	%rax, %rax
               	je	<addr>
               	orq	%r12, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movzwq	-0x70(%rbp), %rcx
               	nop
               	jmp	<addr>
               	movss	%xmm0, -0x88(%rbp)
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %r12d
               	xorl	%eax, %eax
               	movl	%eax, -0x58(%rbp)
               	movss	-0x88(%rbp), %xmm0
               	movss	%xmm0, -0x40(%rbp)
               	movl	-0x40(%rbp), %edi
               	movl	$0x2, %esi
               	leaq	-0x58(%rbp), %rcx
               	movq	%r12, %rdx
               	vzeroupper
               	callq	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x80(%rbp)
               	movl	$0x1, %eax
               	cmpl	$0x1, %eax
               	jl	<addr>
               	movl	-0x58(%rbp), %eax
               	nopl	(%rax,%rax)
               	testq	%rax, %rax
               	je	<addr>
               	orq	%r12, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movzwq	-0x80(%rbp), %rcx
               	jmp	<addr>
               	nopl	(%rax)
               	cmpl	$0x1, %eax
               	jl	<addr>
               	movss	%xmm0, -0x98(%rbp)
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %r12d
               	xorl	%eax, %eax
               	movl	%eax, -0x58(%rbp)
               	movss	-0x98(%rbp), %xmm0
               	movss	%xmm0, -0x48(%rbp)
               	movl	-0x48(%rbp), %edi
               	movl	$0x1, %esi
               	leaq	-0x58(%rbp), %rcx
               	movq	%r12, %rdx
               	vzeroupper
               	callq	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x90(%rbp)
               	movl	$0x1, %eax
               	nopw	(%rax,%rax)
               	cmpl	$0x1, %eax
               	jl	<addr>
               	movl	-0x58(%rbp), %eax
               	testq	%rax, %rax
               	je	<addr>
               	orq	%r12, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movzwq	-0x90(%rbp), %rcx
               	jmp	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movss	%xmm0, -0xa8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %r12d
               	xorl	%eax, %eax
               	movl	%eax, -0x58(%rbp)
               	movss	-0xa8(%rbp), %xmm0
               	movss	%xmm0, -0x50(%rbp)
               	movl	-0x50(%rbp), %edi
               	xorl	%esi, %esi
               	leaq	-0x58(%rbp), %rcx
               	movq	%r12, %rdx
               	vzeroupper
               	callq	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0xa0(%rbp)
               	movl	$0x1, %eax
               	nopw	(%rax,%rax)
               	cmpl	$0x1, %eax
               	jl	<addr>
               	movl	-0x58(%rbp), %eax
               	testq	%rax, %rax
               	je	<addr>
               	orq	%r12, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movzwq	-0xa0(%rbp), %rcx
               	jmp	<addr>
               	incq	%rbx
               	cmpl	$0x54, %ebx
               	jb	<addr>
               	movl	$0x33800000, -0x8(%rbp) # imm = 0x33800000
               	movss	-0x8(%rbp), %xmm0
               	movss	%xmm0, -0xb8(%rbp)
               	movl	-0xb8(%rbp), %eax
               	cmpl	$0x33800000, %eax       # imm = 0x33800000
               	je	<addr>
               	movl	$0x2, %eax
               	leaq	-0x100(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	vzeroupper
               	leave
               	retq
               	movl	$0x387fc000, -0x8(%rbp) # imm = 0x387FC000
               	movss	-0x8(%rbp), %xmm0
               	movss	%xmm0, -0xb8(%rbp)
               	movl	-0xb8(%rbp), %eax
               	cmpl	$0x387fc000, %eax       # imm = 0x387FC000
               	jne	<addr>
               	movl	$0x38800000, -0x8(%rbp) # imm = 0x38800000
               	movss	-0x8(%rbp), %xmm0
               	movss	%xmm0, -0xb8(%rbp)
               	movl	-0xb8(%rbp), %eax
               	cmpl	$0x38800000, %eax       # imm = 0x38800000
               	jne	<addr>
               	movl	$0x3f800000, -0x8(%rbp) # imm = 0x3F800000
               	movss	-0x8(%rbp), %xmm0
               	movss	%xmm0, -0xb8(%rbp)
               	movl	-0xb8(%rbp), %eax
               	cmpl	$0x3f800000, %eax       # imm = 0x3F800000
               	jne	<addr>
               	movl	$0x477fe000, -0x8(%rbp) # imm = 0x477FE000
               	movss	-0x8(%rbp), %xmm0
               	movss	%xmm0, -0xb8(%rbp)
               	movl	-0xb8(%rbp), %eax
               	cmpl	$0x477fe000, %eax       # imm = 0x477FE000
               	jne	<addr>
               	movl	$0xc77fe000, -0x8(%rbp) # imm = 0xC77FE000
               	movss	-0x8(%rbp), %xmm0
               	movss	%xmm0, -0xb8(%rbp)
               	movl	-0xb8(%rbp), %eax
               	cmpl	$0xc77fe000, %eax       # imm = 0xC77FE000
               	jne	<addr>
               	movl	$0x7f800000, -0x8(%rbp) # imm = 0x7F800000
               	movss	-0x8(%rbp), %xmm0
               	movss	%xmm0, -0xb8(%rbp)
               	movl	-0xb8(%rbp), %eax
               	cmpl	$0x7f800000, %eax       # imm = 0x7F800000
               	jne	<addr>
               	movl	$0x7fc02000, -0x8(%rbp) # imm = 0x7FC02000
               	movss	-0x8(%rbp), %xmm0
               	movss	%xmm0, -0xb8(%rbp)
               	movl	-0xb8(%rbp), %eax
               	cmpl	$0x7fc02000, %eax       # imm = 0x7FC02000
               	jne	<addr>
               	movl	$0xffc02000, -0x8(%rbp) # imm = 0xFFC02000
               	movss	-0x8(%rbp), %xmm0
               	movss	%xmm0, -0xb8(%rbp)
               	movl	-0xb8(%rbp), %eax
               	cmpl	$0xffc02000, %eax       # imm = 0xFFC02000
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	vmovups	(%rax), %ymm1
               	leaq	-0x20(%rbp), %r13
               	vmovups	%ymm1, -0x20(%rbp)
               	leaq	-0x38(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x38(%rbp), %r12d
               	xorl	%ebx, %ebx
               	movl	%ebx, -0x40(%rbp)
               	vmovups	%ymm1, -0xe0(%rbp)
               	movss	-0x20(%rbp,%rbx,4), %xmm0
               	movss	%xmm0, -0x38(%rbp)
               	movl	-0x38(%rbp), %edi
               	xorl	%esi, %esi
               	leaq	-0x40(%rbp), %rcx
               	movq	%r12, %rdx
               	vzeroupper
               	callq	<addr>
               	vmovups	-0xe0(%rbp), %ymm1
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x30(%rbp,%rbx,2)
               	incq	%rbx
               	cmpl	$0x8, %ebx
               	jl	<addr>
               	movl	-0x40(%rbp), %eax
               	testq	%rax, %rax
               	je	<addr>
               	orq	%r12, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	leaq	-0x30(%rbp), %r14
               	movups	-0x30(%rbp), %xmm0
               	vpermilps	$0x0, %xmm1, %xmm2 # xmm2 = xmm1[0,0,0,0]
               	movss	%xmm2, -0x30(%rbp)
               	vpermilps	$0x1, %xmm1, %xmm2 # xmm2 = xmm1[1,0,0,0]
               	movss	%xmm2, -0x2c(%rbp)
               	vpermilps	$0x2, %xmm1, %xmm2 # xmm2 = xmm1[2,0,0,0]
               	movss	%xmm2, -0x28(%rbp)
               	vpermilps	$0x3, %xmm1, %xmm1 # xmm1 = xmm1[3,0,0,0]
               	movss	%xmm1, -0x24(%rbp)
               	leaq	-0x10(%rbp), %r12
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%r12)
               	leaq	-0x38(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x38(%rbp), %r13d
               	xorl	%ebx, %ebx
               	movl	%ebx, -0x40(%rbp)
               	movups	%xmm0, -0xd0(%rbp)
               	movss	-0x30(%rbp,%rbx,4), %xmm1
               	movss	%xmm1, -0x38(%rbp)
               	movl	-0x38(%rbp), %edi
               	xorl	%esi, %esi
               	leaq	-0x40(%rbp), %rcx
               	movq	%r13, %rdx
               	vzeroupper
               	callq	<addr>
               	movups	-0xd0(%rbp), %xmm0
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x10(%rbp,%rbx,2)
               	incq	%rbx
               	cmpl	$0x4, %ebx
               	jl	<addr>
               	movl	-0x40(%rbp), %eax
               	testq	%rax, %rax
               	je	<addr>
               	orq	%r13, %rax
               	movl	%eax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	ldmxcsr	(%rax)
               	movups	-0x10(%rbp), %xmm1
               	movups	%xmm0, -0x10(%rbp)
               	movups	%xmm1, -0x20(%rbp)
               	xorl	%eax, %eax
               	leaq	<rip>, %r8 # <addr>
               	movzwq	-0x10(%rbp,%rax,2), %rdx
               	movzwq	(%r8,%rax,2), %rcx
               	cmpl	%ecx, %edx
               	jne	<addr>
               	movzwq	-0x20(%rbp,%rax,2), %rdx
               	xorl	%esi, %esi
               	cmpl	$0x4, %eax
               	cmovgeq	%rsi, %rcx
               	cmpl	%ecx, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	vpextrw	$0x0, %xmm0, %eax
               	movswq	%ax, %rax
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
               	orq	$0x7f800000, %rcx       # imm = 0x7F800000
               	movq	%rax, %rdx
               	shlq	$0xd, %rdx
               	orq	$0x400000, %rdx         # imm = 0x400000
               	xorl	%esi, %esi
               	testq	%rax, %rax
               	cmoveq	%rsi, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, -0x8(%rbp)
               	movss	-0x8(%rbp), %xmm1
               	vmovd	%xmm1, %r11d
               	vmovd	%r11d, %xmm1
               	vpextrw	$0x1, %xmm0, %eax
               	movswq	%ax, %rax
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
               	orq	$0x7f800000, %rcx       # imm = 0x7F800000
               	movq	%rax, %rdx
               	shlq	$0xd, %rdx
               	orq	$0x400000, %rdx         # imm = 0x400000
               	xorl	%esi, %esi
               	testq	%rax, %rax
               	cmoveq	%rsi, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, -0x8(%rbp)
               	movss	-0x8(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x1, %r11d, %xmm1, %xmm1
               	vpextrw	$0x2, %xmm0, %eax
               	movswq	%ax, %rax
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
               	orq	$0x7f800000, %rcx       # imm = 0x7F800000
               	movq	%rax, %rdx
               	shlq	$0xd, %rdx
               	orq	$0x400000, %rdx         # imm = 0x400000
               	xorl	%esi, %esi
               	testq	%rax, %rax
               	cmoveq	%rsi, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, -0x8(%rbp)
               	movss	-0x8(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x2, %r11d, %xmm1, %xmm1
               	vpextrw	$0x3, %xmm0, %eax
               	movswq	%ax, %rax
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
               	orq	$0x7f800000, %rcx       # imm = 0x7F800000
               	movq	%rax, %rdx
               	shlq	$0xd, %rdx
               	orq	$0x400000, %rdx         # imm = 0x400000
               	xorl	%esi, %esi
               	testq	%rax, %rax
               	cmoveq	%rsi, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, -0x8(%rbp)
               	movss	-0x8(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x3, %r11d, %xmm1, %xmm1
               	vpextrw	$0x4, %xmm0, %eax
               	movswq	%ax, %rax
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
               	orq	$0x7f800000, %rcx       # imm = 0x7F800000
               	movq	%rax, %rdx
               	shlq	$0xd, %rdx
               	orq	$0x400000, %rdx         # imm = 0x400000
               	xorl	%esi, %esi
               	testq	%rax, %rax
               	cmoveq	%rsi, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, -0x8(%rbp)
               	movss	-0x8(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vmovd	%r11d, %xmm2
               	vpextrw	$0x5, %xmm0, %eax
               	movswq	%ax, %rax
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
               	orq	$0x7f800000, %rcx       # imm = 0x7F800000
               	movq	%rax, %rdx
               	shlq	$0xd, %rdx
               	orq	$0x400000, %rdx         # imm = 0x400000
               	xorl	%esi, %esi
               	testq	%rax, %rax
               	cmoveq	%rsi, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, -0x8(%rbp)
               	movss	-0x8(%rbp), %xmm3
               	vmovd	%xmm3, %r11d
               	vpinsrd	$0x1, %r11d, %xmm2, %xmm2
               	vpextrw	$0x6, %xmm0, %eax
               	movswq	%ax, %rax
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
               	orq	$0x7f800000, %rcx       # imm = 0x7F800000
               	movq	%rax, %rdx
               	shlq	$0xd, %rdx
               	orq	$0x400000, %rdx         # imm = 0x400000
               	xorl	%esi, %esi
               	testq	%rax, %rax
               	cmoveq	%rsi, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, -0x8(%rbp)
               	movss	-0x8(%rbp), %xmm3
               	vmovd	%xmm3, %r11d
               	vpinsrd	$0x2, %r11d, %xmm2, %xmm2
               	vpextrw	$0x7, %xmm0, %eax
               	movswq	%ax, %rax
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
               	orq	$0x7f800000, %rcx       # imm = 0x7F800000
               	movq	%rax, %rdx
               	shlq	$0xd, %rdx
               	orq	$0x400000, %rdx         # imm = 0x400000
               	xorl	%esi, %esi
               	testq	%rax, %rax
               	cmoveq	%rsi, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, -0x8(%rbp)
               	movss	-0x8(%rbp), %xmm3
               	vmovd	%xmm3, %r11d
               	vpinsrd	$0x3, %r11d, %xmm2, %xmm2
               	vinserti128	$0x1, %xmm2, %ymm1, %ymm1
               	vmovups	%ymm1, (%rsp)
               	vpextrw	$0x0, %xmm0, %eax
               	movswq	%ax, %rax
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
               	orq	$0x7f800000, %rcx       # imm = 0x7F800000
               	movq	%rax, %rdx
               	shlq	$0xd, %rdx
               	orq	$0x400000, %rdx         # imm = 0x400000
               	xorl	%esi, %esi
               	testq	%rax, %rax
               	cmoveq	%rsi, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, -0x8(%rbp)
               	movss	-0x8(%rbp), %xmm1
               	vmovd	%xmm1, %r11d
               	vmovd	%r11d, %xmm1
               	vpextrw	$0x1, %xmm0, %eax
               	movswq	%ax, %rax
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
               	orq	$0x7f800000, %rcx       # imm = 0x7F800000
               	movq	%rax, %rdx
               	shlq	$0xd, %rdx
               	orq	$0x400000, %rdx         # imm = 0x400000
               	xorl	%esi, %esi
               	testq	%rax, %rax
               	cmoveq	%rsi, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, -0x8(%rbp)
               	movss	-0x8(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x1, %r11d, %xmm1, %xmm1
               	vpextrw	$0x2, %xmm0, %eax
               	movswq	%ax, %rax
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
               	orq	$0x7f800000, %rcx       # imm = 0x7F800000
               	movq	%rax, %rdx
               	shlq	$0xd, %rdx
               	orq	$0x400000, %rdx         # imm = 0x400000
               	xorl	%esi, %esi
               	testq	%rax, %rax
               	cmoveq	%rsi, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, -0x8(%rbp)
               	movss	-0x8(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x2, %r11d, %xmm1, %xmm1
               	vpextrw	$0x3, %xmm0, %eax
               	movswq	%ax, %rax
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
               	orq	$0x7f800000, %rcx       # imm = 0x7F800000
               	movq	%rax, %rdx
               	shlq	$0xd, %rdx
               	orq	$0x400000, %rdx         # imm = 0x400000
               	xorl	%esi, %esi
               	testq	%rax, %rax
               	cmoveq	%rsi, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, -0x8(%rbp)
               	movss	-0x8(%rbp), %xmm0
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	leaq	(%rsp), %rcx
               	movss	(%rsp,%rax,4), %xmm1
               	leaq	0x1(%rax), %rcx
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rcx, %xmm0
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	jne	<addr>
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	0x20(%rsp), %rcx
               	movss	0x20(%rsp,%rax,4), %xmm1
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	leaq	-0x100(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	vzeroupper
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	-0x100(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	vzeroupper
               	leave
               	retq
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
               	orq	%rcx, %rsi
               	movl	$0x17, %ecx
               	subq	%rdx, %rcx
               	shlxq	%rcx, %rax, %rcx
               	andq	$0x7fffff, %rcx         # imm = 0x7FFFFF
               	orq	%rsi, %rcx
               	jmp	<addr>
               	addq	$0x70, %rdx
               	shlq	$0x17, %rdx
               	orq	%rcx, %rdx
               	movq	%rax, %rcx
               	shlq	$0xd, %rcx
               	orq	%rdx, %rcx
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
               	orq	%rcx, %rsi
               	movl	$0x17, %ecx
               	subq	%rdx, %rcx
               	shlxq	%rcx, %rax, %rcx
               	andq	$0x7fffff, %rcx         # imm = 0x7FFFFF
               	orq	%rsi, %rcx
               	jmp	<addr>
               	addq	$0x70, %rdx
               	shlq	$0x17, %rdx
               	orq	%rcx, %rdx
               	movq	%rax, %rcx
               	shlq	$0xd, %rcx
               	orq	%rdx, %rcx
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
               	orq	%rcx, %rsi
               	movl	$0x17, %ecx
               	subq	%rdx, %rcx
               	shlxq	%rcx, %rax, %rcx
               	andq	$0x7fffff, %rcx         # imm = 0x7FFFFF
               	orq	%rsi, %rcx
               	jmp	<addr>
               	addq	$0x70, %rdx
               	shlq	$0x17, %rdx
               	orq	%rcx, %rdx
               	movq	%rax, %rcx
               	shlq	$0xd, %rcx
               	orq	%rdx, %rcx
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
               	orq	%rcx, %rsi
               	movl	$0x17, %ecx
               	subq	%rdx, %rcx
               	shlxq	%rcx, %rax, %rcx
               	andq	$0x7fffff, %rcx         # imm = 0x7FFFFF
               	orq	%rsi, %rcx
               	jmp	<addr>
               	addq	$0x70, %rdx
               	shlq	$0x17, %rdx
               	orq	%rcx, %rdx
               	movq	%rax, %rcx
               	shlq	$0xd, %rcx
               	orq	%rdx, %rcx
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
               	orq	%rcx, %rsi
               	movl	$0x17, %ecx
               	subq	%rdx, %rcx
               	shlxq	%rcx, %rax, %rcx
               	andq	$0x7fffff, %rcx         # imm = 0x7FFFFF
               	orq	%rsi, %rcx
               	jmp	<addr>
               	addq	$0x70, %rdx
               	shlq	$0x17, %rdx
               	orq	%rcx, %rdx
               	movq	%rax, %rcx
               	shlq	$0xd, %rcx
               	orq	%rdx, %rcx
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
               	orq	%rcx, %rsi
               	movl	$0x17, %ecx
               	subq	%rdx, %rcx
               	shlxq	%rcx, %rax, %rcx
               	andq	$0x7fffff, %rcx         # imm = 0x7FFFFF
               	orq	%rsi, %rcx
               	jmp	<addr>
               	addq	$0x70, %rdx
               	shlq	$0x17, %rdx
               	orq	%rcx, %rdx
               	movq	%rax, %rcx
               	shlq	$0xd, %rcx
               	orq	%rdx, %rcx
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
               	orq	%rcx, %rsi
               	movl	$0x17, %ecx
               	subq	%rdx, %rcx
               	shlxq	%rcx, %rax, %rcx
               	andq	$0x7fffff, %rcx         # imm = 0x7FFFFF
               	orq	%rsi, %rcx
               	jmp	<addr>
               	addq	$0x70, %rdx
               	shlq	$0x17, %rdx
               	orq	%rcx, %rdx
               	movq	%rax, %rcx
               	shlq	$0xd, %rcx
               	orq	%rdx, %rcx
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
               	orq	%rcx, %rsi
               	movl	$0x17, %ecx
               	subq	%rdx, %rcx
               	shlxq	%rcx, %rax, %rcx
               	andq	$0x7fffff, %rcx         # imm = 0x7FFFFF
               	orq	%rsi, %rcx
               	jmp	<addr>
               	addq	$0x70, %rdx
               	shlq	$0x17, %rdx
               	orq	%rcx, %rdx
               	movq	%rax, %rcx
               	shlq	$0xd, %rcx
               	orq	%rdx, %rcx
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
               	orq	%rcx, %rsi
               	movl	$0x17, %ecx
               	subq	%rdx, %rcx
               	shlxq	%rcx, %rax, %rcx
               	andq	$0x7fffff, %rcx         # imm = 0x7FFFFF
               	orq	%rsi, %rcx
               	jmp	<addr>
               	addq	$0x70, %rdx
               	shlq	$0x17, %rdx
               	orq	%rcx, %rdx
               	movq	%rax, %rcx
               	shlq	$0xd, %rcx
               	orq	%rdx, %rcx
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
               	orq	%rcx, %rsi
               	movl	$0x17, %ecx
               	subq	%rdx, %rcx
               	shlxq	%rcx, %rax, %rcx
               	andq	$0x7fffff, %rcx         # imm = 0x7FFFFF
               	orq	%rsi, %rcx
               	jmp	<addr>
               	addq	$0x70, %rdx
               	shlq	$0x17, %rdx
               	orq	%rcx, %rdx
               	movq	%rax, %rcx
               	shlq	$0xd, %rcx
               	orq	%rdx, %rcx
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
               	orq	%rcx, %rsi
               	movl	$0x17, %ecx
               	subq	%rdx, %rcx
               	shlxq	%rcx, %rax, %rcx
               	andq	$0x7fffff, %rcx         # imm = 0x7FFFFF
               	orq	%rsi, %rcx
               	jmp	<addr>
               	addq	$0x70, %rdx
               	shlq	$0x17, %rdx
               	orq	%rcx, %rdx
               	movq	%rax, %rcx
               	shlq	$0xd, %rcx
               	orq	%rdx, %rcx
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
               	orq	%rcx, %rsi
               	movl	$0x17, %ecx
               	subq	%rdx, %rcx
               	shlxq	%rcx, %rax, %rcx
               	andq	$0x7fffff, %rcx         # imm = 0x7FFFFF
               	orq	%rsi, %rcx
               	jmp	<addr>
               	addq	$0x70, %rdx
               	shlq	$0x17, %rdx
               	orq	%rcx, %rdx
               	movq	%rax, %rcx
               	shlq	$0xd, %rcx
               	orq	%rdx, %rcx
               	jmp	<addr>
               	movl	$0x3, %eax
               	leaq	-0x100(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	vzeroupper
               	leave
               	retq
               	movl	$0x1, %eax
               	leaq	-0x100(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	vzeroupper
               	leave
               	retq
