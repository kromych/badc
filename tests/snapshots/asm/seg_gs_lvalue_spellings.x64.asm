
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
               	retq

<rmw_direct>:
               	leaq	<rip>, %rax
               	movslq	%gs:(%rax), %rcx
               	addq	%rdi, %rcx
               	movl	%ecx, %gs:(%rax)
               	retq

<rd_dot>:
               	leaq	<rip>, %rax
               	movq	%gs:(%rax), %rax
               	retq

<wr_dot>:
               	leaq	<rip>, %rax
               	movq	%rdi, %gs:(%rax)
               	retq

<rd_arrow>:
               	movq	%gs:(%rdi), %rax
               	retq

<wr_arrow>:
               	leaq	0x20(%rdi), %rax
               	movq	%rsi, %gs:(%rax)
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
               	movl	%edx, %gs:(%rax)
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
               	movl	%gs:(%rax), %edx
               	andq	$-0x8, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, %gs:(%rax)
               	retq

<ca_member>:
               	leaq	0x20(%rdi), %rax
               	movq	%gs:(%rax), %rcx
               	addq	%rsi, %rcx
               	movq	%rcx, %gs:(%rax)
               	retq

<copy_ptr>:
               	movq	%rdi, %rax
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x28, %eax
               	leaq	<rip>, %rcx
               	movl	%eax, %gs:(%rcx)
               	leaq	<rip>, %rax
               	movslq	%gs:(%rax), %rcx
               	addq	$0x2, %rcx
               	movl	%ecx, %gs:(%rax)
               	leaq	<rip>, %rax
               	movslq	%gs:(%rax), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
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
               	leave
               	retq
               	movl	$0x9e, %eax
               	movl	$0x1001, %edi           # imm = 0x1001
               	leaq	<rip>, %rsi
               	syscall
               	movq	%rax, -0x8(%rbp)
               	cmpq	$0x0, -0x8(%rbp)
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorl	%esi, %esi
               	movl	$0x7, %ecx
               	movl	$0x20, %eax
               	movq	%rcx, %gs:(%rax)
               	movq	%gs:(%rax), %rcx
               	addq	$0x5, %rcx
               	movq	%rcx, %gs:(%rax)
               	movl	$0x10, %eax
               	movl	$0x9, %ecx
               	movl	%ecx, %gs:(%rax)
               	movl	$0x1c, %ecx
               	movl	%gs:(%rcx), %edx
               	andq	$0x7, %rdx
               	orq	$0x5, %rdx
               	movl	%gs:(%rcx), %edi
               	andq	$-0x8, %rdi
               	orq	%rdi, %rdx
               	movl	%edx, %gs:(%rcx)
               	movl	%gs:(%rax), %edx
               	movl	%gs:(%rax), %r8d
               	movq	%gs:(%rsi), %r9
               	leaq	<rip>, %rax
               	movq	%rsi, (%rax)
               	movl	$0x9e, %eax
               	movl	$0x1001, %edi           # imm = 0x1001
               	xorl	%esi, %esi
               	syscall
               	movq	%rax, -0x8(%rbp)
               	cmpq	$0x0, -0x8(%rbp)
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	%rdx, %rax
               	xorq	$0x9, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%r8, %rax
               	xorq	$0x9, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	testq	%r9, %r9
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	addq	$0x20, %rax
               	movq	(%rax), %rax
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	addq	$0x10, %rax
               	movl	(%rax), %eax
               	xorq	$0x9, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	addq	$0x1c, %rax
               	movl	(%rax), %eax
               	andq	$0x7, %rax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	addq	$0x1c, %rax
               	movl	(%rax), %eax
               	sarq	$0x3, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movl	$0x2a, %eax
               	leave
               	retq
