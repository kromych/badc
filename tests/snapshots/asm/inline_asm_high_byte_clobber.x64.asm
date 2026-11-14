
inline_asm_high_byte_clobber.x64:	file format elf64-x86-64

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

<touch>:
               	movq	<rip>, %rax # <addr>
               	incq	%rax
               	movq	%rax, <rip> # <addr>
               	retq

<across>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	leaq	(%rdi,%rdi,2), %rax
               	leaq	0x1(%rax), %r12
               	leaq	(%rsi,%rsi,4), %rax
               	leaq	0x2(%rax), %r13
               	imulq	$0x7, %rdx, %rax
               	leaq	0x3(%rax), %r14
               	imulq	$0xb, %rcx, %rax
               	leaq	0x4(%rax), %r15
               	imulq	$0xd, %r8, %rax
               	leaq	0x5(%rax), %r10
               	movq	%r10, 0x38(%rsp)
               	callq	<addr>
               	movb	$0x7f, %bh
               	movb	$0x7f, %ah
               	movb	$0x7f, %ch
               	movb	$0x7f, %dh
               	callq	<addr>
               	shlq	%r13
               	xorq	%r13, %r12
               	shlq	$0x2, %r14
               	xorq	%r14, %r12
               	shlq	$0x3, %r15
               	movq	%r12, %rax
               	xorq	%r15, %rax
               	movq	0x38(%rsp), %rcx
               	shlq	$0x4, %rcx
               	xorq	%rcx, %rax
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	popq	%rbx
               	leave
               	retq

<numbered>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	pushq	%r13
               	pushq	%r12
               	leaq	(%rdi,%rdi,2), %rax
               	addq	%rsi, %rax
               	leaq	(%rdi,%rdi,4), %rcx
               	subq	%rsi, %rcx
               	movq	%rsi, %rdx
               	shlq	$0x4, %rdx
               	movq	%rdi, %r8
               	xorq	%rdx, %r8
               	imulq	$0x7, %rsi, %rdx
               	leaq	(%rdi,%rdx), %r9
               	movq	%rdi, %rdx
               	imulq	%rsi, %rdx
               	leaq	0x1(%rdx), %r12
               	leaq	(%rsi,%rsi,2), %rdx
               	subq	%rdx, %rdi
               	leaq	(%rsi,%rsi,8), %rdx
               	leaq	0x2(%rdx), %r13
               	xorl	%edx, %edx
               	xorl	%ebx, %ebx
               	xorl	%esi, %esi
               	shlq	%rcx
               	addq	%rcx, %rax
               	leaq	(%r8,%r8,2), %rcx
               	addq	%rcx, %rax
               	shlq	$0x2, %r9
               	addq	%r9, %rax
               	leaq	(%r12,%r12,4), %rcx
               	addq	%rcx, %rax
               	imulq	$0x6, %rdi, %rcx
               	addq	%rcx, %rax
               	imulq	$0x7, %r13, %rcx
               	addq	%rcx, %rax
               	popq	%r12
               	popq	%r13
               	popq	%rbx
               	leave
               	retq

<vectors>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movsd	<rip>, %xmm2
               	vmulsd	%xmm2, %xmm0, %xmm7
               	movsd	<rip>, %xmm2
               	vmulsd	%xmm2, %xmm1, %xmm8
               	vaddsd	%xmm1, %xmm0, %xmm9
               	vsubsd	%xmm1, %xmm0, %xmm10
               	vmulsd	%xmm1, %xmm0, %xmm11
               	vdivsd	%xmm1, %xmm0, %xmm12
               	movsd	<rip>, %xmm2
               	vmulsd	%xmm2, %xmm0, %xmm13
               	movsd	<rip>, %xmm6
               	vmulsd	%xmm6, %xmm1, %xmm14
               	movsd	%xmm14, 0x8(%rsp)
               	xorps	%xmm0, %xmm0
               	xorps	%xmm1, %xmm1
               	xorps	%xmm2, %xmm2
               	xorps	%xmm3, %xmm3
               	xorps	%xmm4, %xmm4
               	xorps	%xmm5, %xmm5
               	movsd	<rip>, %xmm0
               	vfmadd213sd	%xmm7, %xmm8, %xmm0 # xmm0 = (xmm8 * xmm0) + xmm7
               	movsd	<rip>, %xmm1
               	vfmadd231sd	%xmm9, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm9) + xmm0
               	movsd	<rip>, %xmm1
               	vfmadd231sd	%xmm10, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm10) + xmm0
               	movsd	<rip>, %xmm1
               	vfmadd231sd	%xmm11, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm11) + xmm0
               	movsd	<rip>, %xmm1
               	vfmadd231sd	%xmm12, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm12) + xmm0
               	vfmadd231sd	%xmm13, %xmm6, %xmm0 # xmm0 = (xmm6 * xmm13) + xmm0
               	movsd	<rip>, %xmm1
               	vfmadd231sd	0x8(%rsp), %xmm1, %xmm0 # xmm0 = (xmm1 * mem) + xmm0
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	<rip>, %rbx # <addr>
               	movq	%rbx, %rsi
               	shlq	%rsi
               	leaq	(%rbx,%rbx,2), %rdx
               	movq	%rbx, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rbx,%rbx,4), %r8
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x59c, %rax            # imm = 0x59C
               	je	<addr>
               	movl	$0x1, %eax
               	movl	$0x2a, %ecx
               	testq	%rax, %rax
               	cmoveq	%rcx, %rax
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %rsi
               	shlq	%rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x127, %rax            # imm = 0x127
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1 # <addr>
               	mulsd	%xmm1, %xmm0
               	movsd	<rip>, %xmm1
               	movsd	<rip>, %xmm2 # <addr>
               	mulsd	%xmm2, %xmm1
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
