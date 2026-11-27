
stepped_pointer_accesses.x64:	file format elf64-x86-64

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

<sum_u8>:
               	xorl	%eax, %eax
               	subq	$0x1, %rsi
               	jb	<addr>
               	leaq	(%rax,%rax,2), %rax
               	incq	%rdi
               	movzbq	-0x1(%rdi), %rcx
               	addq	%rcx, %rax
               	subq	$0x1, %rsi
               	nopl	(%rax,%rax)
               	jae	<addr>
               	retq

<sum_u8_ref>:
               	subq	$0x18, %rsp
               	xorl	%eax, %eax
               	movq	%rax, 0x8(%rsp)
               	jmp	<addr>
               	leaq	(%rax,%rax,2), %rax
               	movq	0x8(%rsp), %rcx
               	movzbq	(%rdi,%rcx), %rcx
               	addq	%rcx, %rax
               	movq	0x8(%rsp), %rcx
               	incq	%rcx
               	movq	%rcx, 0x8(%rsp)
               	movq	0x8(%rsp), %rcx
               	cmpq	%rsi, %rcx
               	jl	<addr>
               	addq	$0x18, %rsp
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
               	nopl	(%rax,%rax)
               	jae	<addr>
               	retq

<sum_i8_ref>:
               	subq	$0x18, %rsp
               	xorl	%eax, %eax
               	movq	%rax, 0x8(%rsp)
               	jmp	<addr>
               	leaq	(%rax,%rax,2), %rax
               	movq	0x8(%rsp), %rcx
               	movsbq	(%rdi,%rcx), %rcx
               	addq	%rcx, %rax
               	movq	0x8(%rsp), %rcx
               	incq	%rcx
               	movq	%rcx, 0x8(%rsp)
               	movq	0x8(%rsp), %rcx
               	cmpq	%rsi, %rcx
               	jl	<addr>
               	addq	$0x18, %rsp
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
               	nopl	(%rax)
               	jae	<addr>
               	retq

<sum_u16_ref>:
               	subq	$0x18, %rsp
               	xorl	%eax, %eax
               	movq	%rax, 0x8(%rsp)
               	jmp	<addr>
               	leaq	(%rax,%rax,2), %rax
               	movq	0x8(%rsp), %rcx
               	movzwq	(%rdi,%rcx,2), %rcx
               	addq	%rcx, %rax
               	movq	0x8(%rsp), %rcx
               	incq	%rcx
               	movq	%rcx, 0x8(%rsp)
               	movq	0x8(%rsp), %rcx
               	cmpq	%rsi, %rcx
               	jl	<addr>
               	addq	$0x18, %rsp
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
               	nopl	(%rax)
               	jae	<addr>
               	retq

<sum_i16_ref>:
               	subq	$0x18, %rsp
               	xorl	%eax, %eax
               	movq	%rax, 0x8(%rsp)
               	jmp	<addr>
               	leaq	(%rax,%rax,2), %rax
               	movq	0x8(%rsp), %rcx
               	movswq	(%rdi,%rcx,2), %rcx
               	addq	%rcx, %rax
               	movq	0x8(%rsp), %rcx
               	incq	%rcx
               	movq	%rcx, 0x8(%rsp)
               	movq	0x8(%rsp), %rcx
               	cmpq	%rsi, %rcx
               	jl	<addr>
               	addq	$0x18, %rsp
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
               	nopw	(%rax,%rax)
               	jae	<addr>
               	retq

<sum_u32_ref>:
               	subq	$0x18, %rsp
               	xorl	%eax, %eax
               	movq	%rax, 0x8(%rsp)
               	jmp	<addr>
               	leaq	(%rax,%rax,2), %rax
               	movq	0x8(%rsp), %rcx
               	movl	(%rdi,%rcx,4), %ecx
               	addq	%rcx, %rax
               	movq	0x8(%rsp), %rcx
               	incq	%rcx
               	movq	%rcx, 0x8(%rsp)
               	movq	0x8(%rsp), %rcx
               	cmpq	%rsi, %rcx
               	jl	<addr>
               	addq	$0x18, %rsp
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
               	nopl	(%rax,%rax)
               	jae	<addr>
               	retq

<sum_i32_ref>:
               	subq	$0x18, %rsp
               	xorl	%eax, %eax
               	movq	%rax, 0x8(%rsp)
               	jmp	<addr>
               	leaq	(%rax,%rax,2), %rax
               	movq	0x8(%rsp), %rcx
               	movslq	(%rdi,%rcx,4), %rcx
               	addq	%rcx, %rax
               	movq	0x8(%rsp), %rcx
               	incq	%rcx
               	movq	%rcx, 0x8(%rsp)
               	movq	0x8(%rsp), %rcx
               	cmpq	%rsi, %rcx
               	jl	<addr>
               	addq	$0x18, %rsp
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
               	nopl	(%rax,%rax)
               	jae	<addr>
               	retq

<sum_u64_ref>:
               	subq	$0x18, %rsp
               	xorl	%eax, %eax
               	movq	%rax, 0x8(%rsp)
               	jmp	<addr>
               	leaq	(%rax,%rax,2), %rax
               	movq	0x8(%rsp), %rcx
               	movq	(%rdi,%rcx,8), %rcx
               	addq	%rcx, %rax
               	movq	0x8(%rsp), %rcx
               	incq	%rcx
               	movq	%rcx, 0x8(%rsp)
               	movq	0x8(%rsp), %rcx
               	cmpq	%rsi, %rcx
               	jl	<addr>
               	addq	$0x18, %rsp
               	retq

<dot>:
               	xorps	%xmm0, %xmm0
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
               	subq	$0x18, %rsp
               	movq	$0x0, 0x8(%rsp)
               	xorps	%xmm0, %xmm0
               	jmp	<addr>
               	movq	0x8(%rsp), %rax
               	vmovq	(%rdi,%rax,8), %xmm1
               	movq	0x8(%rsp), %rax
               	movss	(%rsi,%rax,4), %xmm2
               	cvtss2sd	%xmm2, %xmm2
               	vfmadd231sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm2) + xmm0
               	movq	0x8(%rsp), %rax
               	incq	%rax
               	movq	%rax, 0x8(%rsp)
               	movq	0x8(%rsp), %rax
               	cmpq	%rdx, %rax
               	jl	<addr>
               	addq	$0x18, %rsp
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
               	nopw	(%rax,%rax)
               	cmpq	%rsi, %rax
               	jne	<addr>
               	retq

<main>:
               	subq	$0x170, %rsp            # imm = 0x170
               	pushq	%rbx
               	xorl	%eax, %eax
               	movabsq	$-0x61c8864680b583eb, %rsi # imm = 0x9E3779B97F4A7C15
               	movl	$0x9e3779b9, %edi       # imm = 0x9E3779B9
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	leaq	<rip>, %r10 # <addr>
               	leaq	<rip>, %r11 # <addr>
               	leaq	<rip>, %rbx # <addr>
               	imulq	$0x25, %rax, %rcx
               	addq	$0xc8, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%r8,%rax)
               	imulq	$0x1003, %rax, %rcx     # imm = 0x1003
               	addq	$0x9c40, %rcx           # imm = 0x9C40
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movw	%cx, (%r9,%rax,2)
               	leaq	0x1(%rax), %rcx
               	movq	%rcx, %rdx
               	imulq	%rdi, %rdx
               	movl	%edx, (%r10,%rax,4)
               	leaq	0x3(%rax), %rdx
               	imulq	%rsi, %rdx
               	movq	%rdx, (%r11,%rax,8)
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movsd	<rip>, %xmm1
               	movsd	<rip>, %xmm2
               	vfmsub213sd	%xmm2, %xmm0, %xmm1 # xmm1 = (xmm0 * xmm1) - xmm2
               	movsd	%xmm1, (%rbx,%rax,8)
               	leaq	<rip>, %rdx # <addr>
               	movsd	<rip>, %xmm1
               	movsd	<rip>, %xmm2
               	vfmsub213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) - xmm2
               	cvtsd2ss	%xmm0, %xmm0
               	movss	%xmm0, (%rdx,%rax,4)
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
               	addq	$0x170, %rsp            # imm = 0x170
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
               	addq	$0x170, %rsp            # imm = 0x170
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
               	addq	$0x170, %rsp            # imm = 0x170
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
               	addq	$0x170, %rsp            # imm = 0x170
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
               	addq	$0x170, %rsp            # imm = 0x170
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
               	addq	$0x170, %rsp            # imm = 0x170
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
               	addq	$0x170, %rsp            # imm = 0x170
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
               	addq	$0x170, %rsp            # imm = 0x170
               	retq
               	leaq	<rip>, %rdi # <addr>
               	xorl	%esi, %esi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	addq	$0x170, %rsp            # imm = 0x170
               	retq
               	leaq	0x80(%rsp), %rbx
               	movq	%rbx, %rdi
               	leaq	0xd0(%rsp), %rsi
               	movl	$0x28, %edx
               	movl	$0x5, %ecx
               	callq	<addr>
               	movl	$0x5, %ecx
               	xorl	%eax, %eax
               	movzwq	0x80(%rsp,%rax,2), %rdx
               	movq	%rcx, %rsi
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	cmpl	%esi, %edx
               	jne	<addr>
               	movl	0xd0(%rsp,%rax,4), %edx
               	cmpl	%ecx, %edx
               	jne	<addr>
               	imulq	$0x7, %rcx, %rcx
               	incq	%rcx
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x28, %eax
               	jl	<addr>
               	movl	$0x80018000, 0x20(%rsp) # imm = 0x80018000
               	movl	$0x80038002, 0x24(%rsp) # imm = 0x80038002
               	movl	$0x80058004, 0x28(%rsp) # imm = 0x80058004
               	movl	$0x80078006, 0x2c(%rsp) # imm = 0x80078006
               	leaq	0x20(%rsp), %rax
               	movl	$0x80098008, 0x30(%rsp) # imm = 0x80098008
               	movl	$0x800b800a, 0x34(%rsp) # imm = 0x800B800A
               	leaq	0x2(%rax), %rdi
               	movl	$0xa, %esi
               	callq	<addr>
               	cmpw	$0x0, 0x22(%rsp)
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	addq	$0x170, %rsp            # imm = 0x170
               	retq
               	cmpw	$0x0, 0x24(%rsp)
               	jne	<addr>
               	cmpw	$0x0, 0x26(%rsp)
               	jne	<addr>
               	cmpw	$0x0, 0x28(%rsp)
               	jne	<addr>
               	cmpw	$0x0, 0x2a(%rsp)
               	jne	<addr>
               	cmpw	$0x0, 0x2c(%rsp)
               	jne	<addr>
               	cmpw	$0x0, 0x2e(%rsp)
               	jne	<addr>
               	cmpw	$0x0, 0x30(%rsp)
               	jne	<addr>
               	cmpw	$0x0, 0x32(%rsp)
               	jne	<addr>
               	cmpw	$0x0, 0x34(%rsp)
               	jne	<addr>
               	leaq	0x20(%rsp), %rax
               	movzwq	0x20(%rsp), %rcx
               	cmpl	$0x8000, %ecx           # imm = 0x8000
               	jne	<addr>
               	movzwq	0x36(%rsp), %rcx
               	cmpl	$0x800b, %ecx           # imm = 0x800B
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	addq	$0x170, %rsp            # imm = 0x170
               	retq
               	movw	$0x7, 0x26(%rsp)
               	leaq	0x6(%rax), %rdi
               	callq	<addr>
               	leaq	0x20(%rsp), %rcx
               	leaq	0x8(%rcx), %rdx
               	cmpq	%rdx, %rax
               	jne	<addr>
               	cmpw	$0x0, 0x26(%rsp)
               	jne	<addr>
               	leaq	0x6(%rcx), %rdi
               	callq	<addr>
               	leaq	0x20(%rsp), %rcx
               	addq	$0x6, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	addq	$0x170, %rsp            # imm = 0x170
               	retq
               	leaq	0x58(%rsp), %rsi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movzbq	0x20(%rax), %r10
               	movb	%r10b, 0x20(%rsi)
               	leaq	0x38(%rsp), %rbx
               	movq	%rbx, %rdi
               	movl	$0x20, %edx
               	callq	<addr>
               	xorl	%eax, %eax
               	movsbq	0x38(%rsp,%rax), %rdx
               	movl	$0x1f, %ecx
               	subq	%rax, %rcx
               	movsbq	0x58(%rsp,%rcx), %rcx
               	nop
               	cmpl	%ecx, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x170, %rsp            # imm = 0x170
               	retq
               	movl	$0xb, %eax
               	popq	%rbx
               	addq	$0x170, %rsp            # imm = 0x170
               	retq
               	movl	$0xa, %eax
               	popq	%rbx
               	addq	$0x170, %rsp            # imm = 0x170
               	retq
