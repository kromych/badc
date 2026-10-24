
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
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
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
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm15
               	vmulsd	%xmm15, %xmm0, %xmm6
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm15
               	vmulsd	%xmm15, %xmm1, %xmm7
               	vaddsd	%xmm1, %xmm0, %xmm8
               	vsubsd	%xmm1, %xmm0, %xmm9
               	vmulsd	%xmm1, %xmm0, %xmm10
               	vdivsd	%xmm1, %xmm0, %xmm11
               	movabsq	$0x400a000000000000, %rax # imm = 0x400A000000000000
               	movq	%rax, %xmm15
               	vmulsd	%xmm15, %xmm0, %xmm12
               	movabsq	$0x401c000000000000, %rax # imm = 0x401C000000000000
               	movq	%rax, %xmm15
               	vmulsd	%xmm15, %xmm1, %xmm14
               	movsd	%xmm14, 0x8(%rsp)
               	xorps	%xmm0, %xmm0
               	xorps	%xmm1, %xmm1
               	xorps	%xmm2, %xmm2
               	xorps	%xmm3, %xmm3
               	xorps	%xmm4, %xmm4
               	xorps	%xmm5, %xmm5
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movq	%rcx, %xmm0
               	vfmadd213sd	%xmm6, %xmm7, %xmm0 # xmm0 = (xmm7 * xmm0) + xmm6
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rcx, %xmm14
               	vfmadd231sd	%xmm8, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm8) + xmm0
               	movabsq	$0x4010000000000000, %rcx # imm = 0x4010000000000000
               	movq	%rcx, %xmm14
               	vfmadd231sd	%xmm9, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm9) + xmm0
               	movabsq	$0x4014000000000000, %rcx # imm = 0x4014000000000000
               	movq	%rcx, %xmm14
               	vfmadd231sd	%xmm10, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm10) + xmm0
               	movabsq	$0x4018000000000000, %rcx # imm = 0x4018000000000000
               	movq	%rcx, %xmm14
               	vfmadd231sd	%xmm11, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm11) + xmm0
               	movq	%rax, %xmm14
               	vfmadd231sd	%xmm12, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm12) + xmm0
               	movabsq	$0x4020000000000000, %rax # imm = 0x4020000000000000
               	movq	%rax, %xmm14
               	vfmadd231sd	0x8(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rbx
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
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	jmp	<addr>
               	movq	%rbx, %rsi
               	shlq	%rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x127, %rax            # imm = 0x127
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	leaq	<rip>, %rax      # <addr>
               	movsd	(%rax), %xmm0
               	movq	%rcx, %xmm14
               	vmulsd	%xmm0, %xmm14, %xmm0
               	movabsq	$0x4010000000000000, %rcx # imm = 0x4010000000000000
               	movsd	(%rax), %xmm1
               	movq	%rcx, %xmm14
               	vmulsd	%xmm1, %xmm14, %xmm1
               	callq	<addr>
               	movabsq	$0x4064880000000000, %rax # imm = 0x4064880000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
