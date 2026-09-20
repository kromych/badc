
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

<t_mixed>:
               	leaq	(%rdi,%rdi,4), %rcx
               	leaq	0x1(%rdi), %rax
               	movq	%rdi, %rdx
               	shlq	%rdx
               	addq	%rdx, %rcx
               	leaq	0x7(%rdi), %rdx
               	movswq	%dx, %rdx
               	movsbq	%dil, %rsi
               	xorq	$0x7a, %rsi
               	movsbq	%sil, %rsi
               	leaq	(%rax,%rax), %rdi
               	movq	%rax, %r8
               	shlq	%r8
               	addq	%r8, %rcx
               	addq	%rax, %rdx
               	movswq	%dx, %rdx
               	movsbq	%al, %rax
               	xorq	%rsi, %rax
               	movsbq	%al, %rax
               	movslq	%edi, %rsi
               	addq	%rsi, %rcx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movq	(%rax), %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rbx, %rcx
               	sarq	%rcx
               	shlq	$0x4, %rcx
               	addq	%rbx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rbx, %rcx
               	shlq	%rcx
               	addq	%rcx, %rax
               	imulq	$0x7, %rbx, %rcx
               	addq	$0x9, %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	leaq	(%rax,%rcx), %rdi
               	xorl	%esi, %esi
               	movl	$0x1, %ecx
               	movl	$0x5, %eax
               	movq	%rsi, %rdx
               	addq	%rax, %rdx
               	cmpl	$0x2, %ecx
               	jb	<addr>
               	movq	%rsi, %rcx
               	jmp	<addr>
               	addq	%rbx, %rax
               	movl	$0x2, %ecx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	(%rdx,%rdx,4), %rax
               	leaq	(%rdi,%rax), %r12
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0xb0, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	%rbx, %rax
               	sarq	%rax
               	shlq	$0x4, %rax
               	addq	%rbx, %rax
               	movslq	%eax, %rax
               	addq	%rbx, %rax
               	cmpq	$0x16, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	imulq	$0x7, %rbx, %rax
               	addq	$0x9, %rax
               	cmpq	$0x1e, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	xorl	%esi, %esi
               	movl	$0x1, %ecx
               	movl	$0x5, %eax
               	movq	%rsi, %rdx
               	addq	%rax, %rdx
               	cmpl	$0x2, %ecx
               	jb	<addr>
               	movq	%rsi, %rcx
               	jmp	<addr>
               	addq	%rbx, %rax
               	movl	$0x2, %ecx
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpq	$0xd, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	cmpq	$0x177, %r12            # imm = 0x177
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
