
sroa_one_cell_aggregate_promotes.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	xorl	%edi, %edi
               	movl	$0x1, %eax
               	movl	$0x5, %ecx
               	movq	%rdi, %rsi
               	testl	%eax, %eax
               	je	<addr>
               	movl	%ecx, %r8d
               	addq	%r8, %rsi
               	cmpl	$0x2, %eax
               	jb	<addr>
               	movq	%rdi, %rax
               	jmp	<addr>
               	movl	%edx, %eax
               	leaq	(%r8,%rax), %rcx
               	movl	$0x2, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	0x7(%rdx), %rax
               	movswq	%ax, %rax
               	movsbq	%dl, %r9
               	movq	%r9, %rcx
               	xorq	$0x61, %rcx
               	movsbq	%cl, %rcx
               	movq	%rax, %rdi
               	shlq	%rdi
               	addq	%rdi, %rcx
               	addq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	shlq	%rax
               	leaq	(%rsi,%rax), %rdi
               	movswq	%dx, %r8
               	leaq	0x1(%rdx), %rax
               	movswq	%ax, %rax
               	movq	%rdx, %rcx
               	shlq	%rcx
               	movswq	%cx, %rcx
               	leaq	-0x3(%rdx), %rsi
               	movswq	%si, %rsi
               	shlq	%rax
               	addq	%r8, %rax
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	%rcx, %rax
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	leaq	(%rax,%rax,2), %rax
               	leaq	(%rdi,%rax), %rbx
               	xorl	%esi, %esi
               	movl	$0x1, %eax
               	movl	$0x5, %ecx
               	testl	%eax, %eax
               	je	<addr>
               	movl	%ecx, %edi
               	addq	%rdi, %rsi
               	cmpl	$0x2, %eax
               	jb	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	%edx, %eax
               	leaq	(%rdi,%rax), %rcx
               	movl	$0x2, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpq	$0xd, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	0x7(%rdx), %rax
               	movswq	%ax, %rax
               	movq	%r9, %rcx
               	xorq	$0x61, %rcx
               	movsbq	%cl, %rcx
               	movq	%rax, %rsi
               	shlq	%rsi
               	addq	%rsi, %rcx
               	addq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	cmpq	$0x83, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	0x1(%rdx), %rax
               	movswq	%ax, %rax
               	movq	%rdx, %rcx
               	shlq	%rcx
               	movswq	%cx, %rcx
               	subq	$0x3, %rdx
               	movswq	%dx, %rdx
               	shlq	%rax
               	addq	%r8, %rax
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	cmpl	$0x1d, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	cmpq	$0x16a, %rbx            # imm = 0x16A
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
