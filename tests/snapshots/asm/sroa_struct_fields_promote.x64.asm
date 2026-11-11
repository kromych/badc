
sroa_struct_fields_promote.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	<rip>, %rdx # <addr>
               	leaq	(%rdx,%rdx,4), %rcx
               	leaq	0x1(%rdx), %rax
               	movq	%rdx, %rsi
               	shlq	%rsi
               	addq	%rsi, %rcx
               	leaq	0x7(%rdx), %rsi
               	movswq	%si, %rsi
               	movsbq	%dl, %r8
               	movq	%r8, %rdi
               	xorq	$0x7a, %rdi
               	movsbq	%dil, %rdi
               	leaq	(%rax,%rax), %r9
               	movq	%rax, %rbx
               	shlq	%rbx
               	addq	%rbx, %rcx
               	addq	%rax, %rsi
               	movswq	%si, %rsi
               	movsbq	%al, %rax
               	xorq	%rdi, %rax
               	movsbq	%al, %rax
               	movslq	%r9d, %rdi
               	addq	%rdi, %rcx
               	addq	%rsi, %rcx
               	addq	%rcx, %rax
               	movq	%rdx, %rcx
               	sarq	%rcx
               	shlq	$0x4, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rdx, %rcx
               	shlq	%rcx
               	addq	%rcx, %rax
               	imulq	$0x7, %rdx, %rcx
               	addq	$0x9, %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	leaq	(%rax,%rcx), %r9
               	xorl	%edi, %edi
               	movl	$0x1, %ecx
               	movl	$0x5, %eax
               	movq	%rdi, %rsi
               	addq	%rax, %rsi
               	cmpl	$0x2, %ecx
               	jb	<addr>
               	movq	%rdi, %rcx
               	jmp	<addr>
               	addq	%rdx, %rax
               	movl	$0x2, %ecx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	(%rsi,%rsi,4), %rax
               	addq	%rax, %r9
               	leaq	(%rdx,%rdx,4), %rcx
               	leaq	0x1(%rdx), %rax
               	movq	%rdx, %rsi
               	shlq	%rsi
               	addq	%rsi, %rcx
               	leaq	0x7(%rdx), %rsi
               	movswq	%si, %rsi
               	movq	%r8, %rdi
               	xorq	$0x7a, %rdi
               	movsbq	%dil, %rdi
               	leaq	(%rax,%rax), %r8
               	movq	%rax, %rbx
               	shlq	%rbx
               	addq	%rbx, %rcx
               	addq	%rax, %rsi
               	movswq	%si, %rsi
               	movsbq	%al, %rax
               	xorq	%rdi, %rax
               	movsbq	%al, %rax
               	movslq	%r8d, %rdi
               	addq	%rdi, %rcx
               	addq	%rsi, %rcx
               	addq	%rcx, %rax
               	cmpq	$0xb0, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
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
               	leave
               	retq
               	imulq	$0x7, %rdx, %rax
               	addq	$0x9, %rax
               	cmpq	$0x1e, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	movl	$0x1, %ecx
               	movl	$0x5, %eax
               	movq	%rdi, %rsi
               	addq	%rax, %rsi
               	cmpl	$0x2, %ecx
               	jb	<addr>
               	movq	%rdi, %rcx
               	jmp	<addr>
               	addq	%rdx, %rax
               	movl	$0x2, %ecx
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpq	$0xd, %rsi
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	cmpq	$0x177, %r9             # imm = 0x177
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
