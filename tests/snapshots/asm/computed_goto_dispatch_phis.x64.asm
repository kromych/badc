
computed_goto_dispatch_phis.x64:	file format elf64-x86-64

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

<run>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	xorl	%edx, %edx
               	movl	$0x1, %ecx
               	movq	(%rdi), %rax
               	leaq	<rip>, %r8 # <addr>
               	movq	(%r8,%rax,8), %r9
               	incq	%r9
               	movq	%r9, (%r8,%rax,8)
               	leaq	<rip>, %r8 # <addr>
               	movq	(%r8,%rax,8), %r8
               	movq	%rcx, %rax
               	jmpq	*%r8
               	addq	$0x8, %rsi
               	leaq	0x1(%rax), %r8
               	movq	(%rdi,%rax,8), %rax
               	movq	%rax, -0x8(%rsi)
               	leaq	0x1(%r8), %rax
               	movq	(%rdi,%r8,8), %r8
               	leaq	<rip>, %r9 # <addr>
               	movq	(%r9,%r8,8), %rbx
               	incq	%rbx
               	movq	%rbx, (%r9,%r8,8)
               	incq	%rcx
               	leaq	<rip>, %r9 # <addr>
               	movq	(%r9,%r8,8), %r8
               	jmpq	*%r8
               	addq	$-0x8, %rsi
               	movq	-0x8(%rsi), %r8
               	movq	(%rsi), %r9
               	addq	%r9, %r8
               	movq	%r8, -0x8(%rsi)
               	leaq	0x1(%rax), %r9
               	movq	(%rdi,%rax,8), %rax
               	leaq	<rip>, %r8 # <addr>
               	movq	(%r8,%rax,8), %rbx
               	incq	%rbx
               	movq	%rbx, (%r8,%rax,8)
               	incq	%rcx
               	leaq	<rip>, %r8 # <addr>
               	movq	(%r8,%rax,8), %r8
               	movq	%r9, %rax
               	jmpq	*%r8
               	addq	$-0x8, %rsi
               	movq	-0x8(%rsi), %r8
               	movq	(%rsi), %r9
               	subq	%r9, %r8
               	movq	%r8, -0x8(%rsi)
               	leaq	0x1(%rax), %r9
               	movq	(%rdi,%rax,8), %rax
               	leaq	<rip>, %r8 # <addr>
               	movq	(%r8,%rax,8), %rbx
               	incq	%rbx
               	movq	%rbx, (%r8,%rax,8)
               	incq	%rcx
               	leaq	<rip>, %r8 # <addr>
               	movq	(%r8,%rax,8), %r8
               	movq	%r9, %rax
               	jmpq	*%r8
               	addq	$-0x8, %rsi
               	movq	-0x8(%rsi), %r8
               	movq	(%rsi), %r9
               	imulq	%r9, %r8
               	movq	%r8, -0x8(%rsi)
               	leaq	0x1(%rax), %r9
               	movq	(%rdi,%rax,8), %rax
               	leaq	<rip>, %r8 # <addr>
               	movq	(%r8,%rax,8), %rbx
               	incq	%rbx
               	movq	%rbx, (%r8,%rax,8)
               	incq	%rcx
               	leaq	<rip>, %r8 # <addr>
               	movq	(%r8,%rax,8), %r8
               	movq	%r9, %rax
               	jmpq	*%r8
               	movq	-0x8(%rsi), %r8
               	movq	%r8, (%rsi)
               	addq	$0x8, %rsi
               	leaq	0x1(%rax), %r9
               	movq	(%rdi,%rax,8), %rax
               	leaq	<rip>, %r8 # <addr>
               	movq	(%r8,%rax,8), %rbx
               	incq	%rbx
               	movq	%rbx, (%r8,%rax,8)
               	incq	%rcx
               	leaq	<rip>, %r8 # <addr>
               	movq	(%r8,%rax,8), %r8
               	movq	%r9, %rax
               	jmpq	*%r8
               	movq	-0x8(%rsi), %r8
               	movq	-0x10(%rsi), %r9
               	movq	%r9, -0x8(%rsi)
               	movq	%r8, -0x10(%rsi)
               	leaq	0x1(%rax), %r9
               	movq	(%rdi,%rax,8), %rax
               	leaq	<rip>, %r8 # <addr>
               	movq	(%r8,%rax,8), %rbx
               	incq	%rbx
               	movq	%rbx, (%r8,%rax,8)
               	incq	%rcx
               	leaq	<rip>, %r8 # <addr>
               	movq	(%r8,%rax,8), %r8
               	movq	%r9, %rax
               	jmpq	*%r8
               	leaq	0x1(%rax), %r8
               	movq	(%rdi,%rax,8), %rax
               	cmpq	$0x0, -0x8(%rsi)
               	cmovneq	%rax, %r8
               	leaq	0x1(%r8), %rax
               	movq	(%rdi,%r8,8), %r8
               	leaq	<rip>, %r9 # <addr>
               	movq	(%r9,%r8,8), %rbx
               	incq	%rbx
               	movq	%rbx, (%r9,%r8,8)
               	incq	%rcx
               	leaq	<rip>, %r9 # <addr>
               	movq	(%r9,%r8,8), %r8
               	jmpq	*%r8
               	movq	-0x8(%rsi), %r8
               	decq	%r8
               	movq	%r8, -0x8(%rsi)
               	leaq	0x1(%rax), %r9
               	movq	(%rdi,%rax,8), %rax
               	leaq	<rip>, %r8 # <addr>
               	movq	(%r8,%rax,8), %rbx
               	incq	%rbx
               	movq	%rbx, (%r8,%rax,8)
               	incq	%rcx
               	leaq	<rip>, %r8 # <addr>
               	movq	(%r8,%rax,8), %r8
               	movq	%r9, %rax
               	jmpq	*%r8
               	addq	$0x2, %rdx
               	incq	%rdx
               	leaq	0x1(%rax), %r9
               	movq	(%rdi,%rax,8), %rax
               	leaq	<rip>, %r8 # <addr>
               	movq	(%r8,%rax,8), %rbx
               	incq	%rbx
               	movq	%rbx, (%r8,%rax,8)
               	incq	%rcx
               	leaq	<rip>, %r8 # <addr>
               	movq	(%r8,%rax,8), %r8
               	movq	%r9, %rax
               	jmpq	*%r8
               	movq	(%rdi,%rax,8), %r8
               	addq	%r8, %rdx
               	leaq	0x1(%rax), %r8
               	movq	(%rdi,%r8,8), %r8
               	shlq	%r8
               	addq	%r8, %rdx
               	leaq	0x2(%rax), %r8
               	movq	(%rdi,%r8,8), %r8
               	leaq	(%r8,%r8,2), %r8
               	addq	%r8, %rdx
               	leaq	0x3(%rax), %r8
               	movq	(%rdi,%r8,8), %r8
               	shlq	$0x2, %r8
               	addq	%r8, %rdx
               	leaq	0x4(%rax), %r8
               	leaq	0x1(%r8), %rax
               	movq	(%rdi,%r8,8), %r8
               	leaq	<rip>, %r9 # <addr>
               	movq	(%r9,%r8,8), %rbx
               	incq	%rbx
               	movq	%rbx, (%r9,%r8,8)
               	incq	%rcx
               	leaq	<rip>, %r9 # <addr>
               	movq	(%r9,%r8,8), %r8
               	jmpq	*%r8
               	leaq	0x1(%rax), %r9
               	movq	(%rdi,%rax,8), %rax
               	leaq	<rip>, %r8 # <addr>
               	movq	(%r8,%rax,8), %rbx
               	incq	%rbx
               	movq	%rbx, (%r8,%rax,8)
               	incq	%rcx
               	leaq	<rip>, %r8 # <addr>
               	movq	(%r8,%rax,8), %r8
               	movq	%r9, %rax
               	jmpq	*%r8
               	jmp	<addr>
               	movq	-0x8(%rsi), %rax
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	imulq	$0xa, %rdx, %rdx
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	popq	%rbx
               	leave
               	retq

<run_switch>:
               	xorl	%r8d, %r8d
               	movq	%r8, %rcx
               	movq	%r8, %rdx
               	leaq	0x1(%rdx), %rax
               	movq	(%rdi,%rdx,8), %rdx
               	incq	%r8
               	cmpq	$0xd, %rdx
               	jae	<addr>
               	leaq	<rip>, %r11 # <addr>
               	movq	(%r11,%rdx,8), %r10
               	jmpq	*%r10
               	addq	$0x8, %rsi
               	leaq	0x1(%rax), %rdx
               	movq	(%rdi,%rax,8), %rax
               	movq	%rax, -0x8(%rsi)
               	jmp	<addr>
               	addq	$-0x8, %rsi
               	movq	-0x8(%rsi), %rdx
               	movq	(%rsi), %r9
               	addq	%r9, %rdx
               	movq	%rdx, -0x8(%rsi)
               	movq	%rax, %rdx
               	jmp	<addr>
               	addq	$-0x8, %rsi
               	movq	-0x8(%rsi), %rdx
               	movq	(%rsi), %r9
               	subq	%r9, %rdx
               	movq	%rdx, -0x8(%rsi)
               	movq	%rax, %rdx
               	jmp	<addr>
               	addq	$-0x8, %rsi
               	movq	-0x8(%rsi), %rdx
               	movq	(%rsi), %r9
               	imulq	%r9, %rdx
               	movq	%rdx, -0x8(%rsi)
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	-0x8(%rsi), %rdx
               	movq	%rdx, (%rsi)
               	addq	$0x8, %rsi
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	-0x8(%rsi), %rdx
               	movq	-0x10(%rsi), %r9
               	movq	%r9, -0x8(%rsi)
               	movq	%rdx, -0x10(%rsi)
               	movq	%rax, %rdx
               	jmp	<addr>
               	leaq	0x1(%rax), %rdx
               	movq	(%rdi,%rax,8), %rax
               	cmpq	$0x0, -0x8(%rsi)
               	cmovneq	%rax, %rdx
               	jmp	<addr>
               	movq	-0x8(%rsi), %rdx
               	decq	%rdx
               	movq	%rdx, -0x8(%rsi)
               	movq	%rax, %rdx
               	jmp	<addr>
               	addq	$0x3, %rcx
               	movq	%rax, %rdx
               	jmp	<addr>
               	incq	%rcx
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	(%rdi,%rax,8), %rdx
               	addq	%rdx, %rcx
               	leaq	0x1(%rax), %rdx
               	movq	(%rdi,%rdx,8), %rdx
               	shlq	%rdx
               	addq	%rdx, %rcx
               	leaq	0x2(%rax), %rdx
               	movq	(%rdi,%rdx,8), %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	addq	%rdx, %rcx
               	leaq	0x3(%rax), %rdx
               	movq	(%rdi,%rdx,8), %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	leaq	0x4(%rax), %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	leaq	0x1(%rdx), %rax
               	movq	(%rdi,%rdx,8), %rdx
               	incq	%r8
               	cmpq	$0xd, %rdx
               	jb	<addr>
               	movq	-0x8(%rsi), %rax
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	retq

<pressure>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x68, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, 0x58(%rsp)
               	movl	$0xb, %r10d
               	movq	%r10, 0x50(%rsp)
               	movl	$0x1, %eax
               	movl	$0x2, %r10d
               	movq	%r10, 0x68(%rsp)
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
               	movq	%rcx, -0x20(%rbp)
               	leaq	<rip>, %rcx # <addr>
               	movq	%rcx, -0x18(%rbp)
               	leaq	<rip>, %rcx # <addr>
               	movq	%rcx, -0x10(%rbp)
               	leaq	<rip>, %rcx # <addr>
               	movq	%rcx, -0x8(%rbp)
               	leaq	-0x20(%rbp), %r10
               	movq	%r10, 0x60(%rsp)
               	movl	$0x1, %ecx
               	movq	0x58(%rsp), %r10
               	movzbq	(%r10), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x60(%rsp), %r10
               	movq	0x48(%rsp), %r11
               	movq	(%r10,%r11,8), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x60(%rsp), %r10
               	jmpq	*%r10
               	addq	%rdx, %rax
               	movq	0x68(%rsp), %r10
               	addq	%rax, %r10
               	movq	%r10, 0x68(%rsp)
               	addq	0x68(%rsp), %r15
               	addq	%r15, %r14
               	xorq	%r14, %r13
               	addq	%r13, %r12
               	leaq	-0x20(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movslq	%ecx, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x60(%rsp), %rcx
               	incq	%rcx
               	movq	0x60(%rsp), %r10
               	imulq	$0x2e8ba2e9, %r10, %r10 # imm = 0x2E8BA2E9
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	sarq	$0x21, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	shrq	$0x3f, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x48(%rsp), %r10
               	addq	0x38(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	imulq	0x50(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x60(%rsp), %r10
               	subq	0x48(%rsp), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x58(%rsp), %r10
               	movq	0x60(%rsp), %r11
               	movzbq	(%r10,%r11), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x40(%rsp), %r10
               	movq	0x60(%rsp), %r11
               	movq	(%r10,%r11,8), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x60(%rsp), %r10
               	jmpq	*%r10
               	addq	%r12, %rbx
               	subq	%rbx, %rdi
               	addq	%rdi, %r9
               	xorq	%r9, %r8
               	addq	%r8, %rsi
               	addq	%rsi, %rdx
               	leaq	-0x20(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movslq	%ecx, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x60(%rsp), %rcx
               	incq	%rcx
               	movq	0x60(%rsp), %r10
               	imulq	$0x2e8ba2e9, %r10, %r10 # imm = 0x2E8BA2E9
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	sarq	$0x21, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	shrq	$0x3f, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x48(%rsp), %r10
               	addq	0x38(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	imulq	0x50(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x60(%rsp), %r10
               	subq	0x48(%rsp), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x58(%rsp), %r10
               	movq	0x60(%rsp), %r11
               	movzbq	(%r10,%r11), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x40(%rsp), %r10
               	movq	0x60(%rsp), %r11
               	movq	(%r10,%r11,8), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x60(%rsp), %r10
               	jmpq	*%r10
               	leaq	-0x20(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movslq	%ecx, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x60(%rsp), %rcx
               	imulq	$0x2e8ba2e9, %rcx, %rcx # imm = 0x2E8BA2E9
               	sarq	$0x21, %rcx
               	movq	%rcx, %r10
               	shrq	$0x3f, %r10
               	movq	%r10, 0x40(%rsp)
               	addq	0x40(%rsp), %rcx
               	imulq	0x50(%rsp), %rcx
               	movq	%rcx, %r10
               	movq	0x60(%rsp), %rcx
               	subq	%r10, %rcx
               	movq	0x58(%rsp), %r10
               	movzbq	(%r10,%rcx), %rcx
               	leaq	<rip>, %r10 # <addr>
               	movq	%r10, 0x40(%rsp)
               	leaq	0x3e8(%rax), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x48(%rsp), %r10
               	movq	(%r10,%rcx,8), %rcx
               	cmpq	0x40(%rsp), %rcx
               	movq	0x38(%rsp), %r10
               	cmoveq	%r10, %rax
               	movq	0x68(%rsp), %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x68(%rsp)
               	addq	%r15, %r14
               	subq	%r13, %r12
               	addq	%rbx, %rdi
               	subq	%r9, %r8
               	xorq	%rsi, %rdx
               	leaq	-0x20(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x60(%rsp), %rcx
               	incq	%rcx
               	movq	0x60(%rsp), %r10
               	imulq	$0x2e8ba2e9, %r10, %r10 # imm = 0x2E8BA2E9
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	sarq	$0x21, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	shrq	$0x3f, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x48(%rsp), %r10
               	addq	0x38(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	imulq	0x50(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x60(%rsp), %r10
               	subq	0x48(%rsp), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x58(%rsp), %r10
               	movq	0x60(%rsp), %r11
               	movzbq	(%r10,%r11), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x40(%rsp), %r10
               	movq	0x60(%rsp), %r11
               	movq	(%r10,%r11,8), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x60(%rsp), %r10
               	jmpq	*%r10
               	movq	0x68(%rsp), %r10
               	shlq	%r10
               	movq	%r10, 0x68(%rsp)
               	addq	0x68(%rsp), %rax
               	leaq	(%r15,%r15,2), %r15
               	addq	%r15, %rax
               	shlq	$0x2, %r14
               	addq	%r14, %rax
               	leaq	(%r13,%r13,4), %r13
               	addq	%r13, %rax
               	imulq	$0x6, %r12, %r12
               	addq	%r12, %rax
               	imulq	$0x7, %rbx, %rbx
               	addq	%rbx, %rax
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
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<pressure_switch>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, 0x48(%rsp)
               	movl	$0xb, %r10d
               	movq	%r10, 0x40(%rsp)
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
               	xorl	%r10d, %r10d
               	movq	%r10, 0x58(%rsp)
               	movq	0x58(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	incq	%r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x50(%rsp), %r10
               	imulq	$0x2e8ba2e9, %r10, %r10 # imm = 0x2E8BA2E9
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %r10
               	sarq	$0x21, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %r10
               	shrq	$0x3f, %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x38(%rsp), %r10
               	addq	0x30(%rsp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %r10
               	imulq	0x40(%rsp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x50(%rsp), %r10
               	subq	0x38(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x48(%rsp), %r10
               	movq	0x50(%rsp), %r11
               	movzbq	(%r10,%r11), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	cmpl	$0x1, %r10d
               	jl	<addr>
               	movq	0x50(%rsp), %r10
               	cmpl	$0x2, %r10d
               	jl	<addr>
               	movq	0x50(%rsp), %r10
               	cmpl	$0x2, %r10d
               	jne	<addr>
               	movq	0x58(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	imulq	$0x2e8ba2e9, %r10, %r10 # imm = 0x2E8BA2E9
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %r10
               	sarq	$0x21, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %r10
               	shrq	$0x3f, %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x38(%rsp), %r10
               	addq	0x30(%rsp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %r10
               	imulq	0x40(%rsp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x50(%rsp), %r10
               	subq	0x38(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x48(%rsp), %r10
               	movq	0x50(%rsp), %r11
               	movzbq	(%r10,%r11), %r10
               	movq	%r10, 0x50(%rsp)
               	leaq	0x3e8(%rax), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x50(%rsp), %r10
               	cmpl	$0x3, %r10d
               	movq	0x38(%rsp), %r10
               	cmoveq	%r10, %rax
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
               	shlq	%r15
               	addq	%r15, %rax
               	leaq	(%r14,%r14,2), %r14
               	addq	%r14, %rax
               	shlq	$0x2, %r13
               	addq	%r13, %rax
               	leaq	(%r12,%r12,4), %r12
               	addq	%r12, %rax
               	imulq	$0x6, %rbx, %rbx
               	addq	%rbx, %rax
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
               	movq	0x58(%rsp), %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<records>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
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
               	movzbq	-0x1(%rax), %rsi
               	shlq	$0x4, %rsi
               	leaq	(%rbx,%rsi), %r9
               	movq	(%r9), %r12
               	movq	0x8(%r9), %r9
               	cmpq	%r8, %r9
               	cmovgq	%r12, %rcx
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
               	popq	%r12
               	popq	%rbp
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	leaq	<rip>, %rdi # <addr>
               	leaq	-0x80(%rbp), %rsi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	<rip>, %rdi # <addr>
               	leaq	-0x80(%rbp), %rsi
               	movq	%rcx, 0x8(%rsp)
               	callq	<addr>
               	movq	0x8(%rsp), %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	cmpq	$0x1badb, %rcx          # imm = 0x1BADB
               	je	<addr>
               	movl	$0x2, %eax
               	leave
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
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	cmpq	$0x1f, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0xb, %esi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	<rip>, %rdi # <addr>
               	movl	$0xb, %esi
               	movq	%rcx, (%rsp)
               	callq	<addr>
               	movq	(%rsp), %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	cmpq	$-0x131e, %rcx          # imm = 0xECE2
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	callq	<addr>
               	cmpq	$0x15403, %rax          # imm = 0x15403
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
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
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
