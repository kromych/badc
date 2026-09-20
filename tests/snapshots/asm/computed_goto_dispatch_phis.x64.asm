
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
               	pushq	%r12
               	pushq	%rbx
               	xorl	%edx, %edx
               	movl	$0x1, %ecx
               	movq	(%rdi), %rax
               	leaq	<rip>, %r8
               	movq	(%r8,%rax,8), %r9
               	incq	%r9
               	movq	%r9, (%r8,%rax,8)
               	leaq	<rip>, %r8
               	movq	(%r8,%rax,8), %r8
               	movq	%rcx, %rax
               	jmpq	*%r8
               	leaq	0x8(%rsi), %rbx
               	leaq	0x1(%rax), %r8
               	movq	(%rdi,%rax,8), %rax
               	movq	%rax, (%rsi)
               	leaq	0x1(%r8), %rax
               	movq	(%rdi,%r8,8), %r8
               	leaq	<rip>, %r9
               	movq	(%r9,%r8,8), %rsi
               	incq	%rsi
               	movq	%rsi, (%r9,%r8,8)
               	incq	%rcx
               	leaq	<rip>, %rsi
               	movq	(%rsi,%r8,8), %r8
               	movq	%rbx, %rsi
               	jmpq	*%r8
               	addq	$-0x8, %rsi
               	leaq	-0x8(%rsi), %r8
               	movq	(%r8), %r9
               	movq	(%rsi), %rbx
               	addq	%rbx, %r9
               	movq	%r9, (%r8)
               	leaq	0x1(%rax), %r9
               	movq	(%rdi,%rax,8), %rax
               	leaq	<rip>, %r8
               	movq	(%r8,%rax,8), %rbx
               	incq	%rbx
               	movq	%rbx, (%r8,%rax,8)
               	incq	%rcx
               	leaq	<rip>, %r8
               	movq	(%r8,%rax,8), %r8
               	movq	%r9, %rax
               	jmpq	*%r8
               	addq	$-0x8, %rsi
               	leaq	-0x8(%rsi), %r8
               	movq	(%r8), %r9
               	movq	(%rsi), %rbx
               	subq	%rbx, %r9
               	movq	%r9, (%r8)
               	leaq	0x1(%rax), %r9
               	movq	(%rdi,%rax,8), %rax
               	leaq	<rip>, %r8
               	movq	(%r8,%rax,8), %rbx
               	incq	%rbx
               	movq	%rbx, (%r8,%rax,8)
               	incq	%rcx
               	leaq	<rip>, %r8
               	movq	(%r8,%rax,8), %r8
               	movq	%r9, %rax
               	jmpq	*%r8
               	addq	$-0x8, %rsi
               	leaq	-0x8(%rsi), %r8
               	movq	(%r8), %r9
               	movq	(%rsi), %rbx
               	imulq	%rbx, %r9
               	movq	%r9, (%r8)
               	leaq	0x1(%rax), %r9
               	movq	(%rdi,%rax,8), %rax
               	leaq	<rip>, %r8
               	movq	(%r8,%rax,8), %rbx
               	incq	%rbx
               	movq	%rbx, (%r8,%rax,8)
               	incq	%rcx
               	leaq	<rip>, %r8
               	movq	(%r8,%rax,8), %r8
               	movq	%r9, %rax
               	jmpq	*%r8
               	leaq	-0x8(%rsi), %r8
               	movq	(%r8), %r8
               	movq	%r8, (%rsi)
               	addq	$0x8, %rsi
               	leaq	0x1(%rax), %r9
               	movq	(%rdi,%rax,8), %rax
               	leaq	<rip>, %r8
               	movq	(%r8,%rax,8), %rbx
               	incq	%rbx
               	movq	%rbx, (%r8,%rax,8)
               	incq	%rcx
               	leaq	<rip>, %r8
               	movq	(%r8,%rax,8), %r8
               	movq	%r9, %rax
               	jmpq	*%r8
               	leaq	-0x8(%rsi), %r8
               	movq	(%r8), %rbx
               	leaq	-0x10(%rsi), %r9
               	movq	(%r9), %r12
               	movq	%r12, (%r8)
               	movq	%rbx, (%r9)
               	leaq	0x1(%rax), %r9
               	movq	(%rdi,%rax,8), %rax
               	leaq	<rip>, %r8
               	movq	(%r8,%rax,8), %rbx
               	incq	%rbx
               	movq	%rbx, (%r8,%rax,8)
               	incq	%rcx
               	leaq	<rip>, %r8
               	movq	(%r8,%rax,8), %r8
               	movq	%r9, %rax
               	jmpq	*%r8
               	leaq	0x1(%rax), %r8
               	movq	(%rdi,%rax,8), %rax
               	leaq	-0x8(%rsi), %r9
               	cmpq	$0x0, (%r9)
               	je	<addr>
               	movq	%rax, %r8
               	leaq	0x1(%r8), %rax
               	movq	(%rdi,%r8,8), %r8
               	leaq	<rip>, %r9
               	movq	(%r9,%r8,8), %rbx
               	incq	%rbx
               	movq	%rbx, (%r9,%r8,8)
               	incq	%rcx
               	leaq	<rip>, %r9
               	movq	(%r9,%r8,8), %r8
               	jmpq	*%r8
               	leaq	-0x8(%rsi), %r8
               	movq	(%r8), %r9
               	decq	%r9
               	movq	%r9, (%r8)
               	leaq	0x1(%rax), %r9
               	movq	(%rdi,%rax,8), %rax
               	leaq	<rip>, %r8
               	movq	(%r8,%rax,8), %rbx
               	incq	%rbx
               	movq	%rbx, (%r8,%rax,8)
               	incq	%rcx
               	leaq	<rip>, %r8
               	movq	(%r8,%rax,8), %r8
               	movq	%r9, %rax
               	jmpq	*%r8
               	addq	$0x2, %rdx
               	incq	%rdx
               	leaq	0x1(%rax), %r9
               	movq	(%rdi,%rax,8), %rax
               	leaq	<rip>, %r8
               	movq	(%r8,%rax,8), %rbx
               	incq	%rbx
               	movq	%rbx, (%r8,%rax,8)
               	incq	%rcx
               	leaq	<rip>, %r8
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
               	leaq	<rip>, %r9
               	movq	(%r9,%r8,8), %rbx
               	incq	%rbx
               	movq	%rbx, (%r9,%r8,8)
               	incq	%rcx
               	leaq	<rip>, %r9
               	movq	(%r9,%r8,8), %r8
               	jmpq	*%r8
               	leaq	0x1(%rax), %r9
               	movq	(%rdi,%rax,8), %rax
               	leaq	<rip>, %r8
               	movq	(%r8,%rax,8), %rbx
               	incq	%rbx
               	movq	%rbx, (%r8,%rax,8)
               	incq	%rcx
               	leaq	<rip>, %r8
               	movq	(%r8,%rax,8), %r8
               	movq	%r9, %rax
               	jmpq	*%r8
               	jmp	<addr>
               	leaq	-0x8(%rsi), %rax
               	movq	(%rax), %rax
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	imulq	$0xa, %rdx, %rdx
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq

<run_switch>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r8d, %r8d
               	movq	%r8, %rcx
               	movq	%r8, %rdx
               	leaq	0x1(%rdx), %rax
               	movq	(%rdi,%rdx,8), %rdx
               	incq	%r8
               	cmpq	$0xd, %rdx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdx,8), %r10
               	jmpq	*%r10
               	leaq	0x8(%rsi), %r9
               	leaq	0x1(%rax), %rdx
               	movq	(%rdi,%rax,8), %rax
               	movq	%rax, (%rsi)
               	movq	%r9, %rsi
               	jmp	<addr>
               	addq	$-0x8, %rsi
               	leaq	-0x8(%rsi), %rdx
               	movq	(%rdx), %r9
               	movq	(%rsi), %rbx
               	addq	%rbx, %r9
               	movq	%r9, (%rdx)
               	movq	%rax, %rdx
               	jmp	<addr>
               	addq	$-0x8, %rsi
               	leaq	-0x8(%rsi), %rdx
               	movq	(%rdx), %r9
               	movq	(%rsi), %rbx
               	subq	%rbx, %r9
               	movq	%r9, (%rdx)
               	movq	%rax, %rdx
               	jmp	<addr>
               	addq	$-0x8, %rsi
               	leaq	-0x8(%rsi), %rdx
               	movq	(%rdx), %r9
               	movq	(%rsi), %rbx
               	imulq	%rbx, %r9
               	movq	%r9, (%rdx)
               	movq	%rax, %rdx
               	jmp	<addr>
               	leaq	-0x8(%rsi), %rdx
               	movq	(%rdx), %rdx
               	movq	%rdx, (%rsi)
               	addq	$0x8, %rsi
               	movq	%rax, %rdx
               	jmp	<addr>
               	leaq	-0x8(%rsi), %rdx
               	movq	(%rdx), %rbx
               	leaq	-0x10(%rsi), %r9
               	movq	(%r9), %r12
               	movq	%r12, (%rdx)
               	movq	%rbx, (%r9)
               	movq	%rax, %rdx
               	jmp	<addr>
               	leaq	0x1(%rax), %rdx
               	movq	(%rdi,%rax,8), %rax
               	leaq	-0x8(%rsi), %r9
               	cmpq	$0x0, (%r9)
               	je	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	leaq	-0x8(%rsi), %rdx
               	movq	(%rdx), %r9
               	decq	%r9
               	movq	%r9, (%rdx)
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
               	leaq	-0x8(%rsi), %rax
               	movq	(%rax), %rax
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
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
               	leaq	<rip>, %rcx        # <addr>
               	movq	%rcx, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	leaq	<rip>, %r10       # <addr>
               	movq	%r10, 0x60(%rsp)
               	movq	0x60(%rsp), %r11
               	movq	%r11, 0x8(%rcx)
               	leaq	-0x20(%rbp), %rcx
               	leaq	<rip>, %r10       # <addr>
               	movq	%r10, 0x60(%rsp)
               	movq	0x60(%rsp), %r11
               	movq	%r11, 0x10(%rcx)
               	leaq	-0x20(%rbp), %rcx
               	leaq	<rip>, %r10       # <addr>
               	movq	%r10, 0x60(%rsp)
               	movq	0x60(%rsp), %r11
               	movq	%r11, 0x18(%rcx)
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
               	movq	0x48(%rsp), %r10
               	movq	(%r10,%rcx,8), %rcx
               	leaq	<rip>, %r10        # <addr>
               	movq	%r10, 0x48(%rsp)
               	cmpq	0x48(%rsp), %rcx
               	jne	<addr>
               	addq	$0x3e8, %rax            # imm = 0x3E8
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
               	jb	<addr>
               	movq	0x50(%rsp), %r10
               	cmpl	$0x2, %r10d
               	jb	<addr>
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
               	movq	0x50(%rsp), %r10
               	xorq	$0x3, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	testl	%r10d, %r10d
               	jne	<addr>
               	addq	$0x3e8, %rax            # imm = 0x3E8
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
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rdx
               	leaq	0x1(%rdi), %rax
               	movzbq	(%rdi), %rdi
               	movq	(%rdx,%rdi,8), %r9
               	movq	%rcx, %r8
               	movq	%rcx, %rdx
               	movq	%rcx, %rdi
               	jmpq	*%r9
               	incq	%rdi
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	incq	%rax
               	addq	$0x64, %rdx
               	leaq	0x1(%rax), %r9
               	movzbq	(%rax), %rax
               	shlq	$0x4, %rax
               	addq	%rsi, %rax
               	movq	(%rax), %rbx
               	movq	0x8(%rax), %rax
               	cmpq	%r8, %rax
               	jle	<addr>
               	movq	%rbx, %rcx
               	movq	%rax, %r8
               	incq	%rdx
               	leaq	<rip>, %rbx
               	leaq	0x1(%r9), %rax
               	movzbq	(%r9), %r9
               	movq	(%rbx,%r9,8), %r9
               	jmpq	*%r9
               	leaq	<rip>, %r9
               	leaq	0x1(%rax), %rbx
               	movzbq	(%rax), %rax
               	movq	(%r9,%rax,8), %r9
               	movq	%rbx, %rax
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
               	leaq	<rip>, %rcx
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
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	<rip>, %rax        # <addr>
               	cmpl	$0x64, %esi
               	jle	<addr>
               	shlq	%rsi
               	leaq	0x2(%rsi), %rax
               	movslq	%eax, %rax
               	retq
               	jmpq	*%rax
               	leaq	0x1(%rsi), %rax
               	retq
               	jmp	<addr>
               	leaq	-<rip>, %rax        # <addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x88, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rdi
               	leaq	-0x80(%rbp), %rsi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rdi
               	leaq	-0x80(%rbp), %rsi
               	callq	<addr>
               	cmpq	%rax, %rbx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	cmpq	$0x1badb, %rbx          # imm = 0x1BADB
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x10(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x18(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x20(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x28(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x30(%rax), %rax
               	addq	%rax, %rcx
               	leaq	<rip>, %rax
               	movq	0x38(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x40(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x48(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x50(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x58(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x60(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x68(%rax), %rax
               	addq	%rcx, %rax
               	cmpq	$0x1f, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	0x30(%rax), %rcx
               	cmpq	$0x3, %rcx
               	jne	<addr>
               	movq	0x50(%rax), %rcx
               	cmpq	$0x1, %rcx
               	jne	<addr>
               	movq	0x68(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movl	$0xb, %esi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rdi
               	movl	$0xb, %esi
               	callq	<addr>
               	cmpq	%rax, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	cmpq	$-0x131e, %rbx          # imm = 0xECE2
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	cmpq	$0x15403, %rax          # imm = 0x15403
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	callq	<addr>
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %edi
               	movl	$0x5, %esi
               	callq	<addr>
               	cmpq	$0x6, %rax
               	jne	<addr>
               	xorl	%edi, %edi
               	movl	$0x5, %esi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	movl	$0xc8, %esi
               	callq	<addr>
               	cmpq	$0x192, %rax            # imm = 0x192
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
