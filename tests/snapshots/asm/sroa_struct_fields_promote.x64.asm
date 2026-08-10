
sroa_struct_fields_promote.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	leaq	(%rdx,%rdx,4), %rax
               	leaq	0x1(%rdx), %rcx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	leaq	(%rax,%rsi), %r9
               	leaq	0x7(%rdx), %rax
               	movswq	%ax, %rsi
               	movsbq	%dl, %r8
               	movq	%r8, %rax
               	xorq	$0x7a, %rax
               	movsbq	%al, %rdi
               	leaq	0x1(%rdx), %rax
               	addq	%rax, %rcx
               	movq	%rax, %rbx
               	shlq	%rbx
               	addq	%rbx, %r9
               	addq	%rax, %rsi
               	movswq	%si, %rsi
               	movsbq	%al, %rax
               	xorq	%rdi, %rax
               	movsbq	%al, %rax
               	movslq	%ecx, %rcx
               	addq	%r9, %rcx
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
               	movl	%eax, %eax
               	cmpq	$0x2, %rax
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
               	leaq	(%rdx,%rdx,4), %rax
               	leaq	0x1(%rdx), %rcx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	leaq	(%rax,%rsi), %rbx
               	leaq	0x7(%rdx), %rax
               	movswq	%ax, %rsi
               	movq	%r8, %rax
               	xorq	$0x7a, %rax
               	movsbq	%al, %rdi
               	leaq	0x1(%rdx), %rax
               	addq	%rax, %rcx
               	movq	%rax, %r8
               	shlq	%r8
               	addq	%rbx, %r8
               	addq	%rax, %rsi
               	movswq	%si, %rsi
               	movsbq	%al, %rax
               	xorq	%rdi, %rax
               	movsbq	%al, %rax
               	movslq	%ecx, %rcx
               	addq	%r8, %rcx
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
               	xorq	%rsi, %rsi
               	movl	$0x1, %eax
               	movl	$0x5, %ecx
               	jmp	<addr>
               	addq	%rcx, %rsi
               	movl	%eax, %eax
               	cmpq	$0x2, %rax
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
               	cmpq	$0xd, %rsi
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
