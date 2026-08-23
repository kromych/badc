
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
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	leaq	(%rdx,%rdx,4), %rcx
               	leaq	0x1(%rdx), %rax
               	movq	%rdx, %rsi
               	shlq	%rsi
               	leaq	(%rcx,%rsi), %rdi
               	leaq	0x7(%rdx), %rcx
               	movswq	%cx, %rcx
               	movsbq	%dl, %r8
               	movq	%r8, %rsi
               	xorq	$0x7a, %rsi
               	movsbq	%sil, %rsi
               	leaq	(%rax,%rax), %r9
               	movq	%rax, %rbx
               	shlq	%rbx
               	addq	%rbx, %rdi
               	addq	%rax, %rcx
               	movswq	%cx, %rcx
               	movsbq	%al, %rax
               	xorq	%rsi, %rax
               	movsbq	%al, %rax
               	movslq	%r9d, %rsi
               	addq	%rdi, %rsi
               	addq	%rsi, %rcx
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
               	leaq	(%rax,%rcx), %r9
               	xorq	%rsi, %rsi
               	movl	$0x1, %eax
               	movl	$0x5, %ecx
               	jmp	<addr>
               	addq	%rcx, %rsi
               	cmpq	$0x2, %rdi
               	jb	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rdi
               	jmp	<addr>
               	addq	%rdx, %rcx
               	movl	$0x2, %eax
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	movl	%eax, %edi
               	testq	%rdi, %rdi
               	jne	<addr>
               	leaq	(%rsi,%rsi,4), %rax
               	addq	%rax, %r9
               	leaq	(%rdx,%rdx,4), %rcx
               	leaq	0x1(%rdx), %rax
               	movq	%rdx, %rsi
               	shlq	%rsi
               	leaq	(%rcx,%rsi), %rdi
               	leaq	0x7(%rdx), %rcx
               	movswq	%cx, %rcx
               	movq	%r8, %rsi
               	xorq	$0x7a, %rsi
               	movsbq	%sil, %rsi
               	leaq	(%rax,%rax), %r8
               	movq	%rax, %rbx
               	shlq	%rbx
               	addq	%rbx, %rdi
               	addq	%rax, %rcx
               	movswq	%cx, %rcx
               	movsbq	%al, %rax
               	xorq	%rsi, %rax
               	movsbq	%al, %rax
               	movslq	%r8d, %rsi
               	addq	%rdi, %rsi
               	addq	%rsi, %rcx
               	addq	%rcx, %rax
               	cmpq	$0xb0, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
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
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	imulq	$0x7, %rdx, %rax
               	addq	$0x9, %rax
               	cmpq	$0x1e, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%r8, %r8
               	movl	$0x1, %eax
               	movl	$0x5, %ecx
               	movq	%r8, %rdi
               	jmp	<addr>
               	addq	%rcx, %rdi
               	cmpq	$0x2, %rsi
               	jb	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rsi
               	jmp	<addr>
               	addq	%rdx, %rcx
               	movl	$0x2, %eax
               	movq	%r8, %rsi
               	jmp	<addr>
               	movl	%eax, %esi
               	testq	%rsi, %rsi
               	jne	<addr>
               	cmpq	$0xd, %rdi
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x177, %r9             # imm = 0x177
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
