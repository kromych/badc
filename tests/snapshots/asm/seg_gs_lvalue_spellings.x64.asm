
seg_gs_lvalue_spellings.x64:	file format elf64-x86-64

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

<rd_direct>:
               	leaq	<rip>, %rax
               	movslq	%gs:(%rax), %rax
               	movslq	%eax, %rax
               	retq

<wr_direct>:
               	leaq	<rip>, %rax
               	movl	%edi, %gs:(%rax)
               	xorq	%rax, %rax
               	retq

<rmw_direct>:
               	leaq	<rip>, %rax
               	movslq	%gs:(%rax), %rcx
               	addq	%rdi, %rcx
               	movl	%ecx, %gs:(%rax)
               	xorq	%rax, %rax
               	retq

<rd_dot>:
               	leaq	<rip>, %rax
               	movq	%gs:(%rax), %rax
               	retq

<wr_dot>:
               	leaq	<rip>, %rax
               	movq	%rdi, %gs:(%rax)
               	xorq	%rax, %rax
               	retq

<rd_arrow>:
               	movq	%gs:(%rdi), %rax
               	retq

<wr_arrow>:
               	leaq	0x20(%rdi), %rax
               	movq	%rsi, %gs:(%rax)
               	xorq	%rax, %rax
               	retq

<rd_index>:
               	movslq	%esi, %rsi
               	movq	%rsi, %rax
               	shlq	$0x2, %rax
               	addq	%rdi, %rax
               	movl	%gs:(%rax), %eax
               	movl	%eax, %eax
               	retq

<wr_index>:
               	movslq	%esi, %rsi
               	movq	%rsi, %rax
               	shlq	$0x2, %rax
               	addq	%rdi, %rax
               	movl	%edx, %ecx
               	movl	%ecx, %gs:(%rax)
               	xorq	%rax, %rax
               	retq

<rd_index_const>:
               	leaq	0x8(%rdi), %rax
               	movl	%gs:(%rax), %eax
               	movl	%eax, %eax
               	retq

<bf_rmw>:
               	leaq	0x1c(%rdi), %rax
               	movl	%gs:(%rax), %ecx
               	andq	$0x7, %rcx
               	orq	$0x5, %rcx
               	andq	$0x7, %rcx
               	movl	%gs:(%rax), %edx
               	andq	$-0x8, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, %gs:(%rax)
               	xorq	%rax, %rax
               	retq

<ca_member>:
               	leaq	0x20(%rdi), %rax
               	movq	%gs:(%rax), %rcx
               	addq	%rsi, %rcx
               	movq	%rcx, %gs:(%rax)
               	xorq	%rax, %rax
               	retq

<copy_ptr>:
               	movq	%rdi, %rax
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movl	$0x28, %eax
               	leaq	<rip>, %rcx
               	movl	%eax, %gs:(%rcx)
               	leaq	<rip>, %rax
               	movslq	%gs:(%rax), %rcx
               	addq	$0x2, %rcx
               	movl	%ecx, %gs:(%rax)
               	leaq	<rip>, %rax
               	movslq	%gs:(%rax), %rax
               	movslq	%eax, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x1122334455667788, %rax # imm = 0x1122334455667788
               	leaq	<rip>, %rcx
               	movq	%rax, %gs:(%rcx)
               	leaq	<rip>, %rax
               	movq	%gs:(%rax), %rax
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	leaq	-0x8(%rbp), %rcx
               	movl	$0x9e, %edx
               	movl	$0x1001, %esi           # imm = 0x1001
               	movq	%rax, -0x60(%rbp)
               	movq	%rcx, -0x58(%rbp)
               	movq	%rsi, -0x50(%rbp)
               	movq	%rdi, -0x48(%rbp)
               	movq	%r11, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	%rdx, -0x30(%rbp)
               	movq	%rsi, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rdi
               	movq	-0x20(%rbp), %rsi
               	syscall
               	movq	-0x38(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x60(%rbp), %rax
               	movq	-0x58(%rbp), %rcx
               	movq	-0x50(%rbp), %rsi
               	movq	-0x48(%rbp), %rdi
               	movq	-0x40(%rbp), %r11
               	movq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	$0x7, %ecx
               	movl	$0x20, %edx
               	movq	%rcx, %gs:(%rdx)
               	movl	$0x20, %ecx
               	movq	%gs:(%rcx), %rdx
               	addq	$0x5, %rdx
               	movq	%rdx, %gs:(%rcx)
               	movl	$0x10, %ecx
               	movl	$0x9, %edx
               	movl	%edx, %gs:(%rcx)
               	movl	$0x1c, %ecx
               	movl	%gs:(%rcx), %edx
               	andq	$0x7, %rdx
               	orq	$0x5, %rdx
               	andq	$0x7, %rdx
               	movl	%gs:(%rcx), %esi
               	andq	$-0x8, %rsi
               	orq	%rsi, %rdx
               	movl	%edx, %gs:(%rcx)
               	movl	$0x10, %ecx
               	movl	%gs:(%rcx), %ecx
               	movl	%ecx, %edx
               	movl	$0x10, %ecx
               	movl	%gs:(%rcx), %ecx
               	movl	%ecx, %esi
               	movq	%gs:(%rax), %rdi
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x8(%rbp), %rcx
               	movl	$0x9e, %r8d
               	movl	$0x1001, %r9d           # imm = 0x1001
               	movq	%rax, -0x60(%rbp)
               	movq	%rcx, -0x58(%rbp)
               	movq	%rsi, -0x50(%rbp)
               	movq	%rdi, -0x48(%rbp)
               	movq	%r11, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	%r8, -0x30(%rbp)
               	movq	%r9, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rdi
               	movq	-0x20(%rbp), %rsi
               	syscall
               	movq	-0x38(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x60(%rbp), %rax
               	movq	-0x58(%rbp), %rcx
               	movq	-0x50(%rbp), %rsi
               	movq	-0x48(%rbp), %rdi
               	movq	-0x40(%rbp), %r11
               	movq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	%edx, %eax
               	xorq	$0x9, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	%esi, %eax
               	xorq	$0x9, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	testq	%rdi, %rdi
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	addq	$0x20, %rax
               	movq	(%rax), %rax
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	addq	$0x10, %rax
               	movl	(%rax), %eax
               	xorq	$0x9, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	addq	$0x1c, %rax
               	movl	(%rax), %eax
               	andq	$0x7, %rax
               	cmpq	$0x5, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	addq	$0x1c, %rax
               	movl	(%rax), %eax
               	sarq	$0x3, %rax
               	andq	$0x1fffffff, %rax       # imm = 0x1FFFFFFF
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
