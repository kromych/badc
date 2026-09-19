
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
               	subq	$0x18, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movl	$0x28, %gs:(%rax)
               	movslq	%gs:(%rax), %rcx
               	addq	$0x2, %rcx
               	movl	%ecx, %gs:(%rax)
               	movslq	%gs:(%rax), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movabsq	$0x1122334455667788, %rcx # imm = 0x1122334455667788
               	leaq	<rip>, %rax
               	movq	%rcx, %gs:(%rax)
               	movq	%gs:(%rax), %rax
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
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
               	popq	%rbx
               	leave
               	retq
               	xorl	%edx, %edx
               	movl	$0x20, %eax
               	movq	$0x7, %gs:(%rax)
               	movq	%gs:(%rax), %rcx
               	addq	$0x5, %rcx
               	movq	%rcx, %gs:(%rax)
               	movl	$0x10, %eax
               	movl	$0x9, %gs:(%rax)
               	movl	$0x1c, %ecx
               	movl	%gs:(%rcx), %esi
               	andq	$0x7, %rsi
               	orq	$0x5, %rsi
               	movl	%gs:(%rcx), %edi
               	andq	$-0x8, %rdi
               	orq	%rdi, %rsi
               	movl	%esi, %gs:(%rcx)
               	movl	%gs:(%rax), %r8d
               	movl	%gs:(%rax), %r9d
               	movq	%gs:(%rdx), %rbx
               	leaq	<rip>, %rax
               	movq	%rdx, (%rax)
               	movl	$0x9e, %eax
               	movl	$0x1001, %edi           # imm = 0x1001
               	xorl	%esi, %esi
               	syscall
               	movq	%rax, -0x8(%rbp)
               	cmpq	$0x0, -0x8(%rbp)
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%r8, %rax
               	xorq	$0x9, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%r9, %rax
               	xorq	$0x9, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	0x20(%rax), %rcx
               	cmpq	$0xc, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	0x10(%rax), %ecx
               	xorq	$0x9, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	0x1c(%rax), %ecx
               	andq	$0x7, %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movl	0x1c(%rax), %eax
               	sarq	$0x3, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	popq	%rbx
               	leave
               	retq
