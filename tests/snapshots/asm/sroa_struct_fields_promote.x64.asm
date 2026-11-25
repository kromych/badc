
sroa_struct_fields_promote.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	<rip>, %rdx # <addr>
               	leaq	(%rdx,%rdx,4), %rcx
               	leaq	0x1(%rdx), %rax
               	movq	%rdx, %rsi
               	shlq	%rsi
               	addq	%rcx, %rsi
               	leaq	0x7(%rdx), %rcx
               	movswq	%cx, %rdi
               	movsbq	%dl, %r12
               	movq	%r12, %rcx
               	xorq	$0x7a, %rcx
               	leaq	(%rax,%rax), %r8
               	movq	%rax, %r9
               	shlq	%r9
               	addq	%r9, %rsi
               	addq	%rax, %rdi
               	movswq	%di, %rdi
               	movsbq	%al, %rax
               	xorq	%rax, %rcx
               	movslq	%r8d, %rax
               	addq	%rsi, %rax
               	addq	%rdi, %rax
               	addq	%rax, %rcx
               	movq	%rdx, %rax
               	sarq	%rax
               	shlq	$0x4, %rax
               	addq	%rdx, %rax
               	movslq	%eax, %rax
               	addq	%rdx, %rax
               	shlq	%rax
               	addq	%rcx, %rax
               	imulq	$0x7, %rdx, %rcx
               	addq	$0x9, %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	leaq	(%rax,%rcx), %r13
               	xorl	%edi, %edi
               	movl	$0x1, %ecx
               	movl	$0x5, %eax
               	movq	%rdi, %rsi
               	addq	%rax, %rsi
               	leaq	(%rax,%rdx), %r9
               	movl	$0x2, %ebx
               	cmpl	$0x2, %ecx
               	movq	%rdi, %rcx
               	cmovbq	%rbx, %rcx
               	cmovbq	%r9, %rax
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	(%rsi,%rsi,4), %rax
               	addq	%rax, %r13
               	leaq	(%rdx,%rdx,4), %rcx
               	leaq	0x1(%rdx), %rax
               	movq	%rdx, %rsi
               	shlq	%rsi
               	addq	%rsi, %rcx
               	leaq	0x7(%rdx), %rsi
               	movswq	%si, %rsi
               	xorq	$0x7a, %r12
               	leaq	(%rax,%rax), %rdi
               	movq	%rax, %r8
               	shlq	%r8
               	addq	%r8, %rcx
               	addq	%rax, %rsi
               	movswq	%si, %rsi
               	movsbq	%al, %rax
               	xorq	%rax, %r12
               	movslq	%edi, %rax
               	addq	%rcx, %rax
               	addq	%rsi, %rax
               	addq	%r12, %rax
               	cmpq	$0xb0, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	retq
               	movq	%rdx, %rax
               	sarq	%rax
               	shlq	$0x4, %rax
               	addq	%rdx, %rax
               	movslq	%eax, %rax
               	addq	%rdx, %rax
               	cmpq	$0x16, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	retq
               	imulq	$0x7, %rdx, %rax
               	addq	$0x9, %rax
               	cmpq	$0x1e, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	retq
               	xorl	%edi, %edi
               	movl	$0x1, %ecx
               	movl	$0x5, %eax
               	movq	%rdi, %rsi
               	addq	%rax, %rsi
               	leaq	(%rax,%rdx), %r9
               	movl	$0x2, %ebx
               	cmpl	$0x2, %ecx
               	movq	%rdi, %rcx
               	cmovbq	%rbx, %rcx
               	cmovbq	%r9, %rax
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpq	$0xd, %rsi
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	retq
               	cmpq	$0x177, %r13            # imm = 0x177
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	retq
