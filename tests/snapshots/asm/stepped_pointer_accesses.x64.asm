
stepped_pointer_accesses.x64:	file format elf64-x86-64

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

<sum_u8>:
               	xorl	%eax, %eax
               	subq	$0x1, %rsi
               	jb	<addr>
               	leaq	(%rax,%rax,2), %rax
               	incq	%rdi
               	movzbq	-0x1(%rdi), %rcx
               	addq	%rcx, %rax
               	subq	$0x1, %rsi
               	jae	<addr>
               	retq

<sum_u8_ref>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorl	%eax, %eax
               	movq	%rax, -0x8(%rbp)
               	jmp	<addr>
               	leaq	(%rax,%rax,2), %rax
               	movq	-0x8(%rbp), %rcx
               	movzbq	(%rdi,%rcx), %rcx
               	addq	%rcx, %rax
               	movq	-0x8(%rbp), %rcx
               	incq	%rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	cmpq	%rsi, %rcx
               	jl	<addr>
               	leave
               	retq

<sum_i8>:
               	xorl	%eax, %eax
               	subq	$0x1, %rsi
               	jb	<addr>
               	leaq	(%rax,%rax,2), %rax
               	incq	%rdi
               	movsbq	-0x1(%rdi), %rcx
               	addq	%rcx, %rax
               	subq	$0x1, %rsi
               	jae	<addr>
               	retq

<sum_i8_ref>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorl	%eax, %eax
               	movq	%rax, -0x8(%rbp)
               	jmp	<addr>
               	leaq	(%rax,%rax,2), %rax
               	movq	-0x8(%rbp), %rcx
               	movsbq	(%rdi,%rcx), %rcx
               	addq	%rcx, %rax
               	movq	-0x8(%rbp), %rcx
               	incq	%rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	cmpq	%rsi, %rcx
               	jl	<addr>
               	leave
               	retq

<sum_u16>:
               	xorl	%eax, %eax
               	subq	$0x1, %rsi
               	jb	<addr>
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x2, %rdi
               	movzwq	-0x2(%rdi), %rcx
               	addq	%rcx, %rax
               	subq	$0x1, %rsi
               	jae	<addr>
               	retq

<sum_u16_ref>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorl	%eax, %eax
               	movq	%rax, -0x8(%rbp)
               	jmp	<addr>
               	leaq	(%rax,%rax,2), %rax
               	movq	-0x8(%rbp), %rcx
               	movzwq	(%rdi,%rcx,2), %rcx
               	addq	%rcx, %rax
               	movq	-0x8(%rbp), %rcx
               	incq	%rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	cmpq	%rsi, %rcx
               	jl	<addr>
               	leave
               	retq

<sum_i16>:
               	xorl	%eax, %eax
               	subq	$0x1, %rsi
               	jb	<addr>
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x2, %rdi
               	movswq	-0x2(%rdi), %rcx
               	addq	%rcx, %rax
               	subq	$0x1, %rsi
               	jae	<addr>
               	retq

<sum_i16_ref>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorl	%eax, %eax
               	movq	%rax, -0x8(%rbp)
               	jmp	<addr>
               	leaq	(%rax,%rax,2), %rax
               	movq	-0x8(%rbp), %rcx
               	movswq	(%rdi,%rcx,2), %rcx
               	addq	%rcx, %rax
               	movq	-0x8(%rbp), %rcx
               	incq	%rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	cmpq	%rsi, %rcx
               	jl	<addr>
               	leave
               	retq

<sum_u32>:
               	xorl	%eax, %eax
               	subq	$0x1, %rsi
               	jb	<addr>
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x4, %rdi
               	movl	-0x4(%rdi), %ecx
               	addq	%rcx, %rax
               	subq	$0x1, %rsi
               	jae	<addr>
               	retq

<sum_u32_ref>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorl	%eax, %eax
               	movq	%rax, -0x8(%rbp)
               	jmp	<addr>
               	leaq	(%rax,%rax,2), %rax
               	movq	-0x8(%rbp), %rcx
               	movl	(%rdi,%rcx,4), %ecx
               	addq	%rcx, %rax
               	movq	-0x8(%rbp), %rcx
               	incq	%rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	cmpq	%rsi, %rcx
               	jl	<addr>
               	leave
               	retq

<sum_i32>:
               	xorl	%eax, %eax
               	subq	$0x1, %rsi
               	jb	<addr>
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x4, %rdi
               	movslq	-0x4(%rdi), %rcx
               	addq	%rcx, %rax
               	subq	$0x1, %rsi
               	jae	<addr>
               	retq

<sum_i32_ref>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorl	%eax, %eax
               	movq	%rax, -0x8(%rbp)
               	jmp	<addr>
               	leaq	(%rax,%rax,2), %rax
               	movq	-0x8(%rbp), %rcx
               	movslq	(%rdi,%rcx,4), %rcx
               	addq	%rcx, %rax
               	movq	-0x8(%rbp), %rcx
               	incq	%rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	cmpq	%rsi, %rcx
               	jl	<addr>
               	leave
               	retq

<sum_u64>:
               	xorl	%eax, %eax
               	subq	$0x1, %rsi
               	jb	<addr>
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x8, %rdi
               	movq	-0x8(%rdi), %rcx
               	addq	%rcx, %rax
               	subq	$0x1, %rsi
               	jae	<addr>
               	retq

<sum_u64_ref>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorl	%eax, %eax
               	movq	%rax, -0x8(%rbp)
               	jmp	<addr>
               	leaq	(%rax,%rax,2), %rax
               	movq	-0x8(%rbp), %rcx
               	movq	(%rdi,%rcx,8), %rcx
               	addq	%rcx, %rax
               	movq	-0x8(%rbp), %rcx
               	incq	%rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	cmpq	%rsi, %rcx
               	jl	<addr>
               	leave
               	retq

<dot>:
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	subq	$0x1, %rdx
               	jb	<addr>
               	addq	$0x8, %rdi
               	movsd	-0x8(%rdi), %xmm1
               	addq	$0x4, %rsi
               	movss	-0x4(%rsi), %xmm2
               	cvtss2sd	%xmm2, %xmm2
               	vfmadd231sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm2) + xmm0
               	subq	$0x1, %rdx
               	jae	<addr>
               	retq

<dot_ref>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	$0x0, -0x8(%rbp)
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	jmp	<addr>
               	movq	-0x8(%rbp), %rax
               	shlq	$0x3, %rax
               	addq	%rdi, %rax
               	movsd	(%rax), %xmm1
               	movq	-0x8(%rbp), %rax
               	shlq	$0x2, %rax
               	addq	%rsi, %rax
               	movss	(%rax), %xmm2
               	cvtss2sd	%xmm2, %xmm2
               	vfmadd231sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm2) + xmm0
               	movq	-0x8(%rbp), %rax
               	incq	%rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	cmpq	%rdx, %rax
               	jl	<addr>
               	leave
               	retq

<fill>:
               	subq	$0x1, %rdx
               	jb	<addr>
               	addq	$0x2, %rdi
               	movq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x2(%rdi)
               	addq	$0x4, %rsi
               	movl	%ecx, -0x4(%rsi)
               	imulq	$0x7, %rcx, %rax
               	leaq	0x1(%rax), %rcx
               	subq	$0x1, %rdx
               	jae	<addr>
               	retq

<clear>:
               	subq	$0x1, %rsi
               	jb	<addr>
               	addq	$0x2, %rdi
               	movw	$0x0, -0x2(%rdi)
               	subq	$0x1, %rsi
               	jae	<addr>
               	retq

<cut>:
               	cmpw	$0x0, (%rdi)
               	je	<addr>
               	addq	$0x2, %rdi
               	movw	$0x0, -0x2(%rdi)
               	movq	%rdi, %rax
               	retq

<reverse>:
               	leaq	(%rsi,%rdx), %rax
               	cmpq	%rsi, %rax
               	je	<addr>
               	incq	%rdi
               	decq	%rax
               	movsbq	(%rax), %rcx
               	movb	%cl, -0x1(%rdi)
               	cmpq	%rsi, %rax
               	jne	<addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x168, %rsp            # imm = 0x168
               	pushq	%rbx
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx # <addr>
               	imulq	$0x25, %rax, %rdx
               	addq	$0xc8, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rcx,%rax)
               	leaq	<rip>, %rcx # <addr>
               	imulq	$0x1003, %rax, %rdx     # imm = 0x1003
               	addq	$0x9c40, %rdx           # imm = 0x9C40
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movw	%dx, (%rcx,%rax,2)
               	leaq	<rip>, %rdx # <addr>
               	leaq	0x1(%rax), %rcx
               	movl	$0x9e3779b9, %esi       # imm = 0x9E3779B9
               	imulq	%rcx, %rsi
               	movl	%esi, (%rdx,%rax,4)
               	leaq	<rip>, %rdx # <addr>
               	leaq	0x3(%rax), %rsi
               	movabsq	$-0x61c8864680b583eb, %r11 # imm = 0x9E3779B97F4A7C15
               	imulq	%r11, %rsi
               	movq	%rsi, (%rdx,%rax,8)
               	leaq	<rip>, %rdx # <addr>
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movabsq	$0x3fd0000000000000, %rsi # imm = 0x3FD0000000000000
               	movabsq	$0x4008000000000000, %rdi # imm = 0x4008000000000000
               	movq	%rsi, %xmm1
               	movq	%rdi, %xmm15
               	vfmsub213sd	%xmm15, %xmm0, %xmm1 # xmm1 = (xmm0 * xmm1) - xmm15
               	movsd	%xmm1, (%rdx)
               	leaq	<rip>, %rdx # <addr>
               	shlq	$0x2, %rax
               	addq	%rdx, %rax
               	movabsq	$0x3ff8000000000000, %rdx # imm = 0x3FF8000000000000
               	movabsq	$0x4034000000000000, %rsi # imm = 0x4034000000000000
               	movq	%rsi, %xmm14
               	movq	%rdx, %xmm15
               	vfmsub132sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm0 * xmm15) - xmm14
               	cvtsd2ss	%xmm0, %xmm0
               	movss	%xmm0, (%rax)
               	movq	%rcx, %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x40, %esi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x40, %esi
               	callq	<addr>
               	cmpq	%rax, %rbx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x40, %esi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x40, %esi
               	callq	<addr>
               	cmpq	%rax, %rbx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x40, %esi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x40, %esi
               	callq	<addr>
               	cmpq	%rax, %rbx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x40, %esi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x40, %esi
               	callq	<addr>
               	cmpq	%rax, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x40, %esi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x40, %esi
               	callq	<addr>
               	cmpq	%rax, %rbx
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x40, %esi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x40, %esi
               	callq	<addr>
               	cmpq	%rax, %rbx
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x40, %esi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x40, %esi
               	callq	<addr>
               	cmpq	%rax, %rbx
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x40, %edx
               	callq	<addr>
               	movsd	%xmm0, 0x18(%rsp)
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x40, %edx
               	callq	<addr>
               	movsd	0x18(%rsp), %xmm14
               	ucomisd	%xmm0, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	xorl	%esi, %esi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xf0(%rbp), %rbx
               	leaq	-0xa0(%rbp), %rsi
               	movl	$0x28, %edx
               	movl	$0x5, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	$0x5, %ecx
               	xorl	%eax, %eax
               	movzwq	(%rbx,%rax,2), %rdx
               	movq	%rcx, %rsi
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	cmpl	%esi, %edx
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rdx
               	movl	(%rdx,%rax,4), %edx
               	cmpl	%ecx, %edx
               	jne	<addr>
               	imulq	$0x7, %rcx, %rcx
               	incq	%rcx
               	incq	%rax
               	cmpl	$0x28, %eax
               	jl	<addr>
               	movl	$0x80018000, -0x150(%rbp) # imm = 0x80018000
               	movl	$0x80038002, -0x14c(%rbp) # imm = 0x80038002
               	movl	$0x80058004, -0x148(%rbp) # imm = 0x80058004
               	leaq	-0x150(%rbp), %rcx
               	movl	$0x80078006, -0x144(%rbp) # imm = 0x80078006
               	movl	$0x80098008, -0x140(%rbp) # imm = 0x80098008
               	movl	$0x800b800a, -0x13c(%rbp) # imm = 0x800B800A
               	leaq	0x2(%rcx), %rdi
               	movl	$0xa, %esi
               	callq	<addr>
               	cmpw	$0x0, -0x14e(%rbp)
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	leave
               	retq
               	cmpw	$0x0, -0x14c(%rbp)
               	jne	<addr>
               	cmpw	$0x0, -0x14a(%rbp)
               	jne	<addr>
               	cmpw	$0x0, -0x148(%rbp)
               	jne	<addr>
               	cmpw	$0x0, -0x146(%rbp)
               	jne	<addr>
               	cmpw	$0x0, -0x144(%rbp)
               	jne	<addr>
               	cmpw	$0x0, -0x142(%rbp)
               	jne	<addr>
               	cmpw	$0x0, -0x140(%rbp)
               	jne	<addr>
               	leaq	-0x150(%rbp), %rax
               	cmpw	$0x0, -0x13e(%rbp)
               	jne	<addr>
               	cmpw	$0x0, -0x13c(%rbp)
               	jne	<addr>
               	movzwq	-0x150(%rbp), %rcx
               	cmpl	$0x8000, %ecx           # imm = 0x8000
               	jne	<addr>
               	movzwq	-0x13a(%rbp), %rcx
               	cmpl	$0x800b, %ecx           # imm = 0x800B
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	leave
               	retq
               	movw	$0x7, -0x14a(%rbp)
               	leaq	0x6(%rax), %rdi
               	callq	<addr>
               	leaq	-0x150(%rbp), %rcx
               	leaq	0x8(%rcx), %rdx
               	cmpq	%rdx, %rax
               	jne	<addr>
               	cmpw	$0x0, -0x14a(%rbp)
               	jne	<addr>
               	leaq	0x6(%rcx), %rdi
               	callq	<addr>
               	leaq	-0x150(%rbp), %rcx
               	addq	$0x6, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x118(%rbp), %rsi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movzbq	0x20(%rax), %r10
               	movb	%r10b, 0x20(%rsi)
               	leaq	-0x138(%rbp), %rbx
               	movl	$0x20, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	movsbq	(%rbx,%rax), %rcx
               	leaq	-0x118(%rbp), %rdx
               	movl	$0x1f, %esi
               	subq	%rax, %rsi
               	movsbq	(%rdx,%rsi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
