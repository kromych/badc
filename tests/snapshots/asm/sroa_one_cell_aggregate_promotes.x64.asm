
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
               	movq	(%rax), %rsi
               	xorl	%edi, %edi
               	movl	$0x1, %ecx
               	movl	$0x5, %eax
               	movq	%rdi, %rdx
               	movl	%eax, %r8d
               	addq	%r8, %rdx
               	cmpl	$0x2, %ecx
               	jb	<addr>
               	movq	%rdi, %rcx
               	jmp	<addr>
               	addq	%rsi, %rax
               	movl	$0x2, %ecx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	0x7(%rsi), %rax
               	movswq	%ax, %rax
               	movsbq	%sil, %r8
               	movq	%r8, %rcx
               	xorq	$0x61, %rcx
               	movsbq	%cl, %rcx
               	movq	%rax, %rdi
               	shlq	%rdi
               	addq	%rdi, %rcx
               	addq	$0x3, %rcx
               	addq	%rcx, %rax
               	shlq	%rax
               	addq	%rdx, %rax
               	movswq	%si, %r9
               	leaq	0x1(%rsi), %rcx
               	movswq	%cx, %rcx
               	movq	%rsi, %rdx
               	shlq	%rdx
               	movswq	%dx, %rdx
               	leaq	-0x3(%rsi), %rdi
               	movswq	%di, %rdi
               	shlq	%rcx
               	addq	%r9, %rcx
               	leaq	(%rdx,%rdx,2), %rdx
               	addq	%rdx, %rcx
               	addq	%rdi, %rcx
               	movslq	%ecx, %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	leaq	(%rax,%rcx), %rbx
               	xorl	%edx, %edx
               	movl	$0x1, %ecx
               	movl	$0x5, %eax
               	movl	%eax, %edi
               	addq	%rdi, %rdx
               	cmpl	$0x2, %ecx
               	jb	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	addq	%rsi, %rax
               	movl	$0x2, %ecx
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpq	$0xd, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	0x7(%rsi), %rax
               	movswq	%ax, %rax
               	movq	%r8, %rcx
               	xorq	$0x61, %rcx
               	movsbq	%cl, %rcx
               	movq	%rax, %rdx
               	shlq	%rdx
               	addq	%rdx, %rcx
               	addq	$0x3, %rcx
               	addq	%rcx, %rax
               	cmpl	$0x83, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	0x1(%rsi), %rax
               	movswq	%ax, %rax
               	movq	%rsi, %rcx
               	shlq	%rcx
               	movswq	%cx, %rcx
               	leaq	-0x3(%rsi), %rdx
               	movswq	%dx, %rdx
               	shlq	%rax
               	addq	%r9, %rax
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
