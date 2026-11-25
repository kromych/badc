
computed_goto_dispatch_phis.x64:	file format elf64-x86-64

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

<run>:
               	pushq	%rbx
               	xorl	%r8d, %r8d
               	movl	$0x1, %ecx
               	movq	(%rdi), %rax
               	leaq	<rip>, %rdx # <addr>
               	movq	(%rdx,%rax,8), %r9
               	incq	%r9
               	movq	%r9, (%rdx,%rax,8)
               	leaq	<rip>, %r9 # <addr>
               	leaq	<rip>, %rbx # <addr>
               	leaq	<rip>, %rdx # <addr>
               	movq	(%r9,%rax,8), %r9
               	movq	%rcx, %rax
               	jmpq	*%r9
               	addq	$0x8, %rsi
               	leaq	0x1(%rax), %r9
               	movq	(%rdi,%rax,8), %rax
               	movq	%rax, -0x8(%rsi)
               	leaq	0x1(%r9), %rax
               	movq	(%rdi,%r9,8), %r9
               	movq	(%rdx,%r9,8), %r10
               	incq	%r10
               	movq	%r10, (%rdx,%r9,8)
               	incq	%rcx
               	movq	(%rbx,%r9,8), %r9
               	jmpq	*%r9
               	addq	$-0x8, %rsi
               	movq	-0x8(%rsi), %r9
               	movq	(%rsi), %r10
               	addq	%r10, %r9
               	movq	%r9, -0x8(%rsi)
               	leaq	0x1(%rax), %r10
               	movq	(%rdi,%rax,8), %rax
               	movq	(%rdx,%rax,8), %r9
               	incq	%r9
               	movq	%r9, (%rdx,%rax,8)
               	incq	%rcx
               	movq	(%rbx,%rax,8), %r9
               	movq	%r10, %rax
               	jmpq	*%r9
               	addq	$-0x8, %rsi
               	movq	-0x8(%rsi), %r9
               	movq	(%rsi), %r10
               	subq	%r10, %r9
               	movq	%r9, -0x8(%rsi)
               	leaq	0x1(%rax), %r10
               	movq	(%rdi,%rax,8), %rax
               	movq	(%rdx,%rax,8), %r9
               	incq	%r9
               	movq	%r9, (%rdx,%rax,8)
               	incq	%rcx
               	movq	(%rbx,%rax,8), %r9
               	movq	%r10, %rax
               	jmpq	*%r9
               	addq	$-0x8, %rsi
               	movq	-0x8(%rsi), %r9
               	movq	(%rsi), %r10
               	imulq	%r10, %r9
               	movq	%r9, -0x8(%rsi)
               	leaq	0x1(%rax), %r10
               	movq	(%rdi,%rax,8), %rax
               	movq	(%rdx,%rax,8), %r9
               	incq	%r9
               	movq	%r9, (%rdx,%rax,8)
               	incq	%rcx
               	movq	(%rbx,%rax,8), %r9
               	movq	%r10, %rax
               	jmpq	*%r9
               	movq	-0x8(%rsi), %r9
               	movq	%r9, (%rsi)
               	addq	$0x8, %rsi
               	leaq	0x1(%rax), %r10
               	movq	(%rdi,%rax,8), %rax
               	movq	(%rdx,%rax,8), %r9
               	incq	%r9
               	movq	%r9, (%rdx,%rax,8)
               	incq	%rcx
               	movq	(%rbx,%rax,8), %r9
               	movq	%r10, %rax
               	jmpq	*%r9
               	movq	-0x8(%rsi), %r9
               	movq	-0x10(%rsi), %r10
               	movq	%r10, -0x8(%rsi)
               	movq	%r9, -0x10(%rsi)
               	leaq	0x1(%rax), %r10
               	movq	(%rdi,%rax,8), %rax
               	movq	(%rdx,%rax,8), %r9
               	incq	%r9
               	movq	%r9, (%rdx,%rax,8)
               	incq	%rcx
               	movq	(%rbx,%rax,8), %r9
               	movq	%r10, %rax
               	jmpq	*%r9
               	leaq	0x1(%rax), %r9
               	movq	(%rdi,%rax,8), %rax
               	cmpq	$0x0, -0x8(%rsi)
               	cmovneq	%rax, %r9
               	leaq	0x1(%r9), %rax
               	movq	(%rdi,%r9,8), %r9
               	movq	(%rdx,%r9,8), %r10
               	incq	%r10
               	movq	%r10, (%rdx,%r9,8)
               	incq	%rcx
               	movq	(%rbx,%r9,8), %r9
               	jmpq	*%r9
               	addq	$-0x1, -0x8(%rsi)
               	leaq	0x1(%rax), %r10
               	movq	(%rdi,%rax,8), %rax
               	movq	(%rdx,%rax,8), %r9
               	incq	%r9
               	movq	%r9, (%rdx,%rax,8)
               	incq	%rcx
               	movq	(%rbx,%rax,8), %r9
               	movq	%r10, %rax
               	jmpq	*%r9
               	addq	$0x2, %r8
               	incq	%r8
               	leaq	0x1(%rax), %r10
               	movq	(%rdi,%rax,8), %rax
               	movq	(%rdx,%rax,8), %r9
               	incq	%r9
               	movq	%r9, (%rdx,%rax,8)
               	incq	%rcx
               	movq	(%rbx,%rax,8), %r9
               	movq	%r10, %rax
               	jmpq	*%r9
               	movq	(%rdi,%rax,8), %r9
               	addq	%r8, %r9
               	leaq	0x1(%rax), %r8
               	movq	(%rdi,%r8,8), %r8
               	shlq	%r8
               	addq	%r9, %r8
               	leaq	0x2(%rax), %r9
               	movq	(%rdi,%r9,8), %r9
               	leaq	(%r9,%r9,2), %r9
               	addq	%r8, %r9
               	leaq	0x3(%rax), %r8
               	movq	(%rdi,%r8,8), %r8
               	shlq	$0x2, %r8
               	addq	%r9, %r8
               	leaq	0x4(%rax), %r9
               	leaq	0x1(%r9), %rax
               	movq	(%rdi,%r9,8), %r9
               	movq	(%rdx,%r9,8), %r10
               	incq	%r10
               	movq	%r10, (%rdx,%r9,8)
               	incq	%rcx
               	movq	(%rbx,%r9,8), %r9
               	jmpq	*%r9
               	leaq	0x1(%rax), %r10
               	movq	(%rdi,%rax,8), %rax
               	movq	(%rdx,%rax,8), %r9
               	incq	%r9
               	movq	%r9, (%rdx,%rax,8)
               	incq	%rcx
               	movq	(%rbx,%rax,8), %r9
               	movq	%r10, %rax
               	jmpq	*%r9
               	jmp	<addr>
               	movq	-0x8(%rsi), %rax
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	imulq	$0xa, %r8, %rdx
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	popq	%rbx
               	retq

<run_switch>:
               	xorl	%r8d, %r8d
               	movq	%r8, %rax
               	movq	%r8, %rdx
               	leaq	0x1(%rdx), %rcx
               	movq	(%rdi,%rdx,8), %rdx
               	incq	%r8
               	cmpq	$0xd, %rdx
               	jae	<addr>
               	leaq	<rip>, %r11 # <addr>
               	movq	(%r11,%rdx,8), %r10
               	jmpq	*%r10
               	addq	$0x8, %rsi
               	leaq	0x1(%rcx), %rdx
               	movq	(%rdi,%rcx,8), %rcx
               	movq	%rcx, -0x8(%rsi)
               	nopl	(%rax)
               	jmp	<addr>
               	addq	$-0x8, %rsi
               	movq	-0x8(%rsi), %rdx
               	movq	(%rsi), %r9
               	addq	%r9, %rdx
               	movq	%rdx, -0x8(%rsi)
               	movq	%rcx, %rdx
               	jmp	<addr>
               	addq	$-0x8, %rsi
               	movq	-0x8(%rsi), %rdx
               	movq	(%rsi), %r9
               	subq	%r9, %rdx
               	movq	%rdx, -0x8(%rsi)
               	movq	%rcx, %rdx
               	jmp	<addr>
               	addq	$-0x8, %rsi
               	movq	-0x8(%rsi), %rdx
               	movq	(%rsi), %r9
               	imulq	%r9, %rdx
               	movq	%rdx, -0x8(%rsi)
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	-0x8(%rsi), %rdx
               	movq	%rdx, (%rsi)
               	addq	$0x8, %rsi
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	-0x8(%rsi), %rdx
               	movq	-0x10(%rsi), %r9
               	movq	%r9, -0x8(%rsi)
               	movq	%rdx, -0x10(%rsi)
               	movq	%rcx, %rdx
               	jmp	<addr>
               	leaq	0x1(%rcx), %rdx
               	movq	(%rdi,%rcx,8), %rcx
               	cmpq	$0x0, -0x8(%rsi)
               	cmovneq	%rcx, %rdx
               	jmp	<addr>
               	addq	$-0x1, -0x8(%rsi)
               	movq	%rcx, %rdx
               	jmp	<addr>
               	addq	$0x3, %rax
               	movq	%rcx, %rdx
               	jmp	<addr>
               	incq	%rax
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	(%rdi,%rcx,8), %rdx
               	addq	%rax, %rdx
               	leaq	0x1(%rcx), %rax
               	movq	(%rdi,%rax,8), %rax
               	shlq	%rax
               	addq	%rdx, %rax
               	leaq	0x2(%rcx), %rdx
               	movq	(%rdi,%rdx,8), %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	addq	%rax, %rdx
               	leaq	0x3(%rcx), %rax
               	movq	(%rdi,%rax,8), %rax
               	shlq	$0x2, %rax
               	addq	%rdx, %rax
               	leaq	0x4(%rcx), %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	leaq	0x1(%rdx), %rcx
               	movq	(%rdi,%rdx,8), %rdx
               	incq	%r8
               	nopw	(%rax,%rax)
               	cmpq	$0xd, %rdx
               	jb	<addr>
               	movq	-0x8(%rsi), %rcx
               	imulq	$0x3e8, %rcx, %rcx      # imm = 0x3E8
               	imulq	$0xa, %rax, %rax
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	retq

<pressure>:
               	subq	$0x88, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	movq	%rdi, 0x80(%rsp)
               	movl	$0xb, %r10d
               	movq	%r10, 0x78(%rsp)
               	movl	$0x1, %eax
               	movl	$0x2, %ebp
               	movl	$0x3, %r15d
               	movl	$0x4, %r14d
               	movl	$0x5, %r13d
               	movl	$0x6, %r12d
               	movl	$0x7, %ebx
               	movl	$0x8, %edi
               	movl	$0x9, %r9d
               	movl	$0xa, %r8d
               	movl	$0xb, %esi
               	movl	$0xc, %edx
               	leaq	<rip>, %rcx # <addr>
               	movq	%rcx, 0x90(%rsp)
               	leaq	<rip>, %rcx # <addr>
               	movq	%rcx, 0x98(%rsp)
               	leaq	<rip>, %rcx # <addr>
               	movq	%rcx, 0xa0(%rsp)
               	leaq	<rip>, %rcx # <addr>
               	movq	%rcx, 0xa8(%rsp)
               	movl	$0x1, %ecx
               	movq	%r10, 0x38(%rsp)
               	movq	0x80(%rsp), %r10
               	movzbq	(%r10), %r11
               	movq	0x38(%rsp), %r10
               	movq	%r9, 0x38(%rsp)
               	movq	0x90(%rsp,%r11,8), %r9
               	movq	%r9, 0x88(%rsp)
               	movq	0x38(%rsp), %r9
               	movq	0x88(%rsp), %r10
               	jmpq	*%r10
               	movq	%rsi, 0x58(%rsp)
               	movq	%rdi, 0x48(%rsp)
               	addq	%rdx, %rax
               	addq	%rax, %rbp
               	addq	%rbp, %r15
               	addq	%r15, %r14
               	xorq	%r14, %r13
               	addq	%r13, %r12
               	movslq	%ecx, %rsi
               	leaq	0x1(%rsi), %rcx
               	imulq	$0x2e8ba2e9, %rsi, %rdi # imm = 0x2E8BA2E9
               	sarq	$0x21, %rdi
               	movq	%rdi, %r10
               	shrq	$0x3f, %r10
               	addq	%rdi, %r10
               	imulq	0x78(%rsp), %r10
               	subq	%r10, %rsi
               	movq	0x80(%rsp), %r11
               	movzbq	(%r11,%rsi), %r10
               	movq	0x90(%rsp,%r10,8), %r11
               	movq	%r11, 0x88(%rsp)
               	movq	0x58(%rsp), %rsi
               	movq	0x48(%rsp), %rdi
               	movq	0x88(%rsp), %r10
               	jmpq	*%r10
               	movq	%rax, 0x50(%rsp)
               	movq	%r13, 0x40(%rsp)
               	addq	%r12, %rbx
               	subq	%rbx, %rdi
               	addq	%rdi, %r9
               	xorq	%r9, %r8
               	addq	%r8, %rsi
               	addq	%rsi, %rdx
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	imulq	$0x2e8ba2e9, %rax, %r13 # imm = 0x2E8BA2E9
               	sarq	$0x21, %r13
               	movq	%r13, %r10
               	shrq	$0x3f, %r10
               	addq	%r13, %r10
               	imulq	0x78(%rsp), %r10
               	subq	%r10, %rax
               	movq	0x80(%rsp), %r11
               	movzbq	(%r11,%rax), %r10
               	movq	0x90(%rsp,%r10,8), %r11
               	movq	%r11, 0x88(%rsp)
               	movq	0x50(%rsp), %rax
               	movq	0x40(%rsp), %r13
               	movq	0x88(%rsp), %r10
               	jmpq	*%r10
               	movslq	%ecx, %r10
               	movq	%r10, 0x88(%rsp)
               	movq	%r10, %rcx
               	imulq	$0x2e8ba2e9, %rcx, %rcx # imm = 0x2E8BA2E9
               	sarq	$0x21, %rcx
               	movq	%rcx, %r10
               	shrq	$0x3f, %r10
               	addq	%r10, %rcx
               	imulq	0x78(%rsp), %rcx
               	movq	0x88(%rsp), %r10
               	subq	%rcx, %r10
               	movq	0x80(%rsp), %r11
               	movzbq	(%r11,%r10), %rcx
               	leaq	<rip>, %r10 # <addr>
               	movq	%r10, 0x68(%rsp)
               	leaq	0x3e8(%rax), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x90(%rsp,%rcx,8), %rcx
               	cmpq	0x68(%rsp), %rcx
               	movq	0x60(%rsp), %r10
               	cmoveq	%r10, %rax
               	xorq	%rax, %rbp
               	addq	%r15, %r14
               	subq	%r13, %r12
               	addq	%rbx, %rdi
               	subq	%r9, %r8
               	xorq	%rsi, %rdx
               	movq	0x88(%rsp), %rcx
               	incq	%rcx
               	movq	0x88(%rsp), %r10
               	imulq	$0x2e8ba2e9, %r10, %r10 # imm = 0x2E8BA2E9
               	movq	%r10, 0x70(%rsp)
               	sarq	$0x21, %r10
               	movq	%r10, 0x70(%rsp)
               	shrq	$0x3f, %r10
               	movq	%r10, %r11
               	movq	0x70(%rsp), %r10
               	addq	%r11, %r10
               	imulq	0x78(%rsp), %r10
               	movq	0x88(%rsp), %r11
               	subq	%r10, %r11
               	movq	%r11, 0x88(%rsp)
               	movq	0x80(%rsp), %r11
               	movq	%r9, 0x30(%rsp)
               	movq	0x88(%rsp), %r9
               	movzbq	(%r11,%r9), %r10
               	movq	0x90(%rsp,%r10,8), %r11
               	movq	%r11, 0x88(%rsp)
               	movq	0x30(%rsp), %r9
               	movq	0x88(%rsp), %r10
               	jmpq	*%r10
               	movq	%rbp, %r10
               	shlq	%r10
               	addq	%r10, %rax
               	leaq	(%r15,%r15,2), %r10
               	addq	%r10, %rax
               	movq	%r14, %r10
               	shlq	$0x2, %r10
               	addq	%r10, %rax
               	leaq	(%r13,%r13,4), %r10
               	addq	%r10, %rax
               	imulq	$0x6, %r12, %r10
               	addq	%r10, %rax
               	imulq	$0x7, %rbx, %r10
               	addq	%r10, %rax
               	shlq	$0x3, %rdi
               	addq	%rdi, %rax
               	leaq	(%r9,%r9,8), %rdi
               	addq	%rdi, %rax
               	imulq	$0xa, %r8, %rdi
               	addq	%rdi, %rax
               	imulq	$0xb, %rsi, %rsi
               	addq	%rsi, %rax
               	imulq	$0xc, %rdx, %rdx
               	addq	%rdx, %rax
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x88, %rsp
               	retq

<pressure_switch>:
               	subq	$0x28, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	movq	%rdi, 0x40(%rsp)
               	movl	$0xb, %r10d
               	movq	%r10, 0x38(%rsp)
               	movl	$0x1, %eax
               	movl	$0x2, %r15d
               	movl	$0x3, %r14d
               	movl	$0x4, %r13d
               	movl	$0x5, %r12d
               	movl	$0x6, %ebx
               	movl	$0x7, %edi
               	movl	$0x8, %r9d
               	movl	$0x9, %r8d
               	movl	$0xa, %esi
               	movl	$0xb, %edx
               	movl	$0xc, %ecx
               	xorl	%ebp, %ebp
               	movslq	%ebp, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%r10, %rbp
               	incq	%rbp
               	movq	0x48(%rsp), %r10
               	imulq	$0x2e8ba2e9, %r10, %r10 # imm = 0x2E8BA2E9
               	sarq	$0x21, %r10
               	movq	%r10, %r11
               	shrq	$0x3f, %r11
               	addq	%r11, %r10
               	imulq	0x38(%rsp), %r10
               	movq	0x48(%rsp), %r11
               	subq	%r10, %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x40(%rsp), %r10
               	movq	0x48(%rsp), %r11
               	movzbq	(%r10,%r11), %r10
               	movq	%r10, 0x48(%rsp)
               	cmpl	$0x1, %r10d
               	jl	<addr>
               	nopl	(%rax,%rax)
               	movq	0x48(%rsp), %r10
               	cmpl	$0x2, %r10d
               	jl	<addr>
               	movq	0x48(%rsp), %r10
               	cmpl	$0x2, %r10d
               	jne	<addr>
               	movslq	%ebp, %r10
               	movq	%r10, 0x48(%rsp)
               	imulq	$0x2e8ba2e9, %r10, %r10 # imm = 0x2E8BA2E9
               	sarq	$0x21, %r10
               	movq	%r10, %r11
               	shrq	$0x3f, %r11
               	addq	%r11, %r10
               	imulq	0x38(%rsp), %r10
               	movq	0x48(%rsp), %r11
               	subq	%r10, %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x40(%rsp), %r10
               	movq	0x48(%rsp), %r11
               	movzbq	(%r10,%r11), %r10
               	movq	%r10, 0x48(%rsp)
               	leaq	0x3e8(%rax), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rsp), %r10
               	cmpl	$0x3, %r10d
               	movq	0x30(%rsp), %r11
               	cmoveq	%r11, %rax
               	xorq	%rax, %r15
               	addq	%r14, %r13
               	subq	%r12, %rbx
               	addq	%rdi, %r9
               	subq	%r8, %rsi
               	xorq	%rdx, %rcx
               	jmp	<addr>
               	addq	%rbx, %rdi
               	subq	%rdi, %r9
               	addq	%r9, %r8
               	xorq	%r8, %rsi
               	addq	%rsi, %rdx
               	addq	%rdx, %rcx
               	jmp	<addr>
               	addq	%rcx, %rax
               	addq	%rax, %r15
               	addq	%r15, %r14
               	addq	%r14, %r13
               	xorq	%r13, %r12
               	addq	%r12, %rbx
               	jmp	<addr>
               	movq	%r15, %r10
               	shlq	%r10
               	addq	%r10, %rax
               	leaq	(%r14,%r14,2), %r10
               	addq	%r10, %rax
               	movq	%r13, %r10
               	shlq	$0x2, %r10
               	addq	%r10, %rax
               	leaq	(%r12,%r12,4), %r10
               	addq	%r10, %rax
               	imulq	$0x6, %rbx, %r10
               	addq	%r10, %rax
               	imulq	$0x7, %rdi, %rdi
               	addq	%rdi, %rax
               	movq	%r9, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rax
               	leaq	(%r8,%r8,8), %rdi
               	addq	%rdi, %rax
               	imulq	$0xa, %rsi, %rsi
               	addq	%rsi, %rax
               	imulq	$0xb, %rdx, %rdx
               	addq	%rdx, %rax
               	imulq	$0xc, %rcx, %rcx
               	addq	%rcx, %rax
               	movslq	%ebp, %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x28, %rsp
               	retq

<records>:
               	pushq	%rbx
               	movq	%rsi, %rbx
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdi), %rax
               	movzbq	-0x1(%rax), %rsi
               	movq	(%rdx,%rsi,8), %r9
               	movq	%rcx, %r8
               	movq	%rcx, %rdx
               	movq	%rcx, %rdi
               	jmpq	*%r9
               	incq	%rdi
               	movzbq	(%rax), %r9
               	testl	%r9d, %r9d
               	jne	<addr>
               	incq	%rax
               	addq	$0x64, %rdx
               	incq	%rax
               	movzbq	-0x1(%rax), %r9
               	shlq	$0x4, %r9
               	addq	%rbx, %r9
               	movq	(%r9), %r10
               	movq	0x8(%r9), %r9
               	cmpq	%r8, %r9
               	cmovgq	%r10, %rcx
               	cmovgq	%r9, %r8
               	incq	%rdx
               	leaq	<rip>, %rsi # <addr>
               	incq	%rax
               	movzbq	-0x1(%rax), %r9
               	movq	(%rsi,%r9,8), %r9
               	jmpq	*%r9
               	leaq	<rip>, %rsi # <addr>
               	incq	%rax
               	movq	(%rsi,%r9,8), %r9
               	jmpq	*%r9
               	jmp	<addr>
               	imulq	$0x2710, %rcx, %rax     # imm = 0x2710
               	imulq	$0x3e8, %r8, %rcx       # imm = 0x3E8
               	addq	%rcx, %rax
               	imulq	$0xa, %rdx, %rcx
               	addq	%rcx, %rax
               	addq	%rdi, %rax
               	popq	%rbx
               	retq

<depth>:
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rdi), %rdx
               	movq	(%rcx,%rdx,8), %rdx
               	jmpq	*%rdx
               	movzbq	0x1(%rdi), %rdx
               	addq	$0x2, %rdi
               	addq	%rdx, %rax
               	nop
               	jmp	<addr>
               	retq

<single>:
               	testl	%edi, %edi
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	cmpl	$0x64, %esi
               	jle	<addr>
               	shlq	%rsi
               	leaq	0x2(%rsi), %rax
               	retq
               	jmpq	*%rax
               	leaq	0x1(%rsi), %rax
               	retq
               	jmp	<addr>
               	leaq	-<rip>, %rax # <addr>
               	jmp	<addr>

<main>:
               	subq	$0x98, %rsp
               	leaq	<rip>, %rdi # <addr>
               	leaq	0x10(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	<rip>, %rdi # <addr>
               	leaq	0x10(%rsp), %rsi
               	movq	%rcx, 0x8(%rsp)
               	callq	<addr>
               	movq	0x8(%rsp), %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x98, %rsp
               	retq
               	cmpq	$0x1badb, %rcx          # imm = 0x1BADB
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x98, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	addq	%rax, %rcx
               	movq	<rip>, %rax # <addr>
               	addq	%rax, %rcx
               	movq	<rip>, %rdx # <addr>
               	addq	%rdx, %rcx
               	movq	<rip>, %rdx # <addr>
               	addq	%rcx, %rdx
               	movq	<rip>, %rcx # <addr>
               	addq	%rcx, %rdx
               	cmpq	$0x1f, %rdx
               	jne	<addr>
               	movq	<rip>, %rdx # <addr>
               	cmpq	$0x3, %rdx
               	jne	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x98, %rsp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0xb, %esi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	<rip>, %rdi # <addr>
               	movl	$0xb, %esi
               	movq	%rcx, 0x8(%rsp)
               	callq	<addr>
               	movq	0x8(%rsp), %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x98, %rsp
               	retq
               	cmpq	$-0x131e, %rcx          # imm = 0xECE2
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x98, %rsp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	callq	<addr>
               	cmpq	$0x15403, %rax          # imm = 0x15403
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x98, %rsp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x98, %rsp
               	retq
               	movl	$0x1, %edi
               	movl	$0x5, %esi
               	callq	<addr>
               	cmpl	$0x6, %eax
               	jne	<addr>
               	xorl	%edi, %edi
               	movl	$0x5, %esi
               	callq	<addr>
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movl	$0x1, %edi
               	movl	$0xc8, %esi
               	callq	<addr>
               	cmpl	$0x192, %eax            # imm = 0x192
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x98, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x98, %rsp
               	retq
