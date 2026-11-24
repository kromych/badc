
switch_jump_table_phi_join.x64:	file format elf64-x86-64

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
               	xorl	%esi, %esi
               	movq	$-0x2, %rcx
               	jmp	<addr>
               	imulq	$0x1f, %rax, %rax
               	addq	%rdx, %rax
               	addq	%rax, %rsi
               	incq	%rcx
               	nopl	(%rax,%rax)
               	cmpl	$0xe, %ecx
               	jge	<addr>
               	movq	$-0x1, %rax
               	xorl	%edx, %edx
               	imulq	$0x21, %rsi, %rdi
               	nopl	(%rax)
               	cmpq	$0xc, %rcx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rcx,8), %r10
               	jmpq	*%r10
               	leaq	0x2(%rdx), %rsi
               	xchgq	%rsi, %rdx
               	addq	%rdx, %rsi
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rsi
               	addq	%rsi, %rdx
               	shlq	%rsi
               	decq	%rdx
               	addq	$0x7, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x1f, %rsi, %rsi
               	addq	%rsi, %rdx
               	leaq	(%rdi,%rdx), %rsi
               	movl	$0x1, %edx
               	imulq	$0x21, %rsi, %rdi
               	cmpq	$0xc, %rcx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rcx,8), %r10
               	jmpq	*%r10
               	xorl	%esi, %esi
               	leaq	0x2(%rsi), %rdx
               	addq	%rdx, %rsi
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rsi
               	addq	%rsi, %rdx
               	shlq	%rsi
               	decq	%rdx
               	addq	$0x7, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x1f, %rsi, %rsi
               	addq	%rsi, %rdx
               	leaq	(%rdi,%rdx), %rsi
               	movl	$0x2, %edx
               	imulq	$0x21, %rsi, %rsi
               	cmpq	$0xc, %rcx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rcx,8), %r10
               	jmpq	*%r10
               	xorl	%eax, %eax
               	leaq	0x2(%rax), %rdx
               	addq	%rdx, %rax
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	addq	%rax, %rdx
               	shlq	%rax
               	decq	%rdx
               	addq	$0x7, %rax
               	addq	%rax, %rdx
               	imulq	$0x1f, %rax, %rax
               	addq	%rdx, %rax
               	leaq	(%rsi,%rax), %rdx
               	xorl	%eax, %eax
               	imulq	$0x21, %rdx, %rdi
               	cmpq	$0xc, %rcx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rcx,8), %r10
               	jmpq	*%r10
               	movl	$0x1, %edx
               	leaq	0x2(%rdx), %rsi
               	leaq	(%rdx,%rsi), %r8
               	leaq	(%rsi,%rsi,2), %rdx
               	movq	%r8, %rsi
               	subq	%rdx, %rsi
               	addq	%rsi, %rdx
               	shlq	%rsi
               	leaq	-0x1(%rdx), %r8
               	leaq	0x7(%rsi), %rdx
               	leaq	(%r8,%rdx), %rsi
               	imulq	$0x1f, %rdx, %rdx
               	addq	%rsi, %rdx
               	leaq	(%rdi,%rdx), %rsi
               	movl	$0x1, %edx
               	imulq	$0x21, %rsi, %rdi
               	cmpq	$0xc, %rcx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rcx,8), %r10
               	jmpq	*%r10
               	leaq	0x2(%rdx), %rsi
               	xchgq	%rsi, %rdx
               	addq	%rdx, %rsi
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rsi
               	addq	%rsi, %rdx
               	shlq	%rsi
               	decq	%rdx
               	addq	$0x7, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x1f, %rsi, %rsi
               	addq	%rsi, %rdx
               	leaq	(%rdi,%rdx), %rsi
               	movl	$0x2, %edx
               	imulq	$0x21, %rsi, %rsi
               	cmpq	$0xc, %rcx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rcx,8), %r10
               	jmpq	*%r10
               	movl	$0x1, %eax
               	leaq	0x2(%rax), %rdx
               	addq	%rdx, %rax
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	addq	%rax, %rdx
               	shlq	%rax
               	decq	%rdx
               	addq	$0x7, %rax
               	addq	%rax, %rdx
               	imulq	$0x1f, %rax, %rax
               	addq	%rdx, %rax
               	addq	%rax, %rsi
               	movl	$0x1, %edx
               	xorl	%eax, %eax
               	imulq	$0x21, %rsi, %rdi
               	nopl	(%rax,%rax)
               	cmpq	$0xc, %rcx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rcx,8), %r10
               	jmpq	*%r10
               	movl	$0x2, %esi
               	leaq	0x2(%rsi), %rax
               	addq	%rax, %rsi
               	leaq	(%rax,%rax,2), %rax
               	subq	%rax, %rsi
               	addq	%rsi, %rax
               	shlq	%rsi
               	decq	%rax
               	addq	$0x7, %rsi
               	addq	%rsi, %rax
               	imulq	$0x1f, %rsi, %rsi
               	addq	%rsi, %rax
               	addq	%rdi, %rax
               	imulq	$0x21, %rax, %rdi
               	cmpq	$0xc, %rcx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rcx,8), %r10
               	jmpq	*%r10
               	movl	$0x2, %eax
               	leaq	0x2(%rax), %rsi
               	leaq	(%rax,%rsi), %r8
               	leaq	(%rsi,%rsi,2), %rax
               	movq	%r8, %rsi
               	subq	%rax, %rsi
               	addq	%rsi, %rax
               	shlq	%rsi
               	leaq	-0x1(%rax), %r8
               	leaq	0x7(%rsi), %rax
               	leaq	(%r8,%rax), %rsi
               	imulq	$0x1f, %rax, %rax
               	addq	%rsi, %rax
               	leaq	(%rdi,%rax), %rsi
               	movl	$0x2, %eax
               	imulq	$0x21, %rsi, %rdi
               	cmpq	$0xc, %rcx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rcx,8), %r10
               	jmpq	*%r10
               	movq	%rax, %rdx
               	leaq	0x2(%rdx), %rsi
               	addq	%rsi, %rdx
               	leaq	(%rsi,%rsi,2), %rsi
               	subq	%rsi, %rdx
               	addq	%rdx, %rsi
               	shlq	%rdx
               	decq	%rsi
               	addq	$0x7, %rdx
               	addq	%rdx, %rsi
               	imulq	$0x1f, %rdx, %rdx
               	addq	%rsi, %rdx
               	leaq	(%rdi,%rdx), %rsi
               	xorl	%edx, %edx
               	imulq	$0x21, %rsi, %rdi
               	nopw	(%rax,%rax)
               	cmpq	$0xc, %rcx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rcx,8), %r10
               	jmpq	*%r10
               	movl	$0x3, %esi
               	leaq	0x2(%rsi), %rdx
               	addq	%rdx, %rsi
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rsi
               	addq	%rsi, %rdx
               	shlq	%rsi
               	decq	%rdx
               	addq	$0x7, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x1f, %rsi, %rsi
               	addq	%rsi, %rdx
               	leaq	(%rdi,%rdx), %rsi
               	movl	$0x1, %edx
               	imulq	$0x21, %rsi, %rdi
               	cmpq	$0xc, %rcx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rcx,8), %r10
               	jmpq	*%r10
               	movl	$0x3, %esi
               	leaq	0x2(%rsi), %rdx
               	addq	%rdx, %rsi
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rsi
               	addq	%rsi, %rdx
               	shlq	%rsi
               	decq	%rdx
               	addq	$0x7, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x1f, %rsi, %rsi
               	addq	%rsi, %rdx
               	leaq	(%rdi,%rdx), %rsi
               	movl	$0x2, %edx
               	imulq	$0x21, %rsi, %rsi
               	cmpq	$0xc, %rcx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rcx,8), %r10
               	jmpq	*%r10
               	movl	$0x3, %eax
               	leaq	0x2(%rax), %rdx
               	addq	%rdx, %rax
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	addq	%rax, %rdx
               	shlq	%rax
               	decq	%rdx
               	addq	$0x7, %rax
               	addq	%rax, %rdx
               	jmp	<addr>
               	movq	$-0x2, %rax
               	jmp	<addr>
               	movq	$-0x2, %rdx
               	jmp	<addr>
               	movl	$0xd, %eax
               	movl	$0x11, %edx
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	$-0x2, %rsi
               	nopl	(%rax)
               	jmp	<addr>
               	movq	$-0x1, %rdx
               	movq	%rax, %rsi
               	jmp	<addr>
               	movl	$0xd, %esi
               	movl	$0x11, %edx
               	nop
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	$-0x2, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	nopl	(%rax)
               	jmp	<addr>
               	movl	$0xd, %esi
               	movl	$0x11, %edx
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	nop
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	$-0x1, %rdx
               	movq	%rax, %rsi
               	nop
               	jmp	<addr>
               	movq	$-0x2, %rsi
               	jmp	<addr>
               	movl	$0xd, %edx
               	movl	$0x11, %esi
               	nopl	(%rax,%rax)
               	jmp	<addr>
               	movq	%rdx, %rax
               	jmp	<addr>
               	movq	%rdx, %rsi
               	movq	%rdx, %rax
               	jmp	<addr>
               	movq	%rdx, %rsi
               	movq	%rdx, %r8
               	nop
               	jmp	<addr>
               	movq	%rdx, %rax
               	movq	%rdx, %r8
               	jmp	<addr>
               	movq	%rdx, %rax
               	movq	%rdx, %rsi
               	jmp	<addr>
               	movq	%rdx, %rax
               	movq	%rdx, %rsi
               	jmp	<addr>
               	movq	%rdx, %rax
               	movq	%rdx, %rsi
               	jmp	<addr>
               	movq	%rdx, %r8
               	movq	%rdx, %rsi
               	jmp	<addr>
               	movq	%rdx, %r8
               	movq	%rdx, %rax
               	jmp	<addr>
               	movq	$-0x1, %rax
               	movq	%rdx, %rsi
               	jmp	<addr>
               	movq	$-0x1, %rsi
               	movq	%rdx, %rax
               	jmp	<addr>
               	movl	$0xd, %eax
               	movl	$0x11, %esi
               	jmp	<addr>
               	movq	%rdx, %rsi
               	jmp	<addr>
               	movq	%rdx, %rsi
               	nop
               	jmp	<addr>
               	movq	%rdx, %rsi
               	jmp	<addr>
               	movq	%rdx, %rsi
               	jmp	<addr>
               	movq	%rdx, %rsi
               	jmp	<addr>
               	movq	%rdx, %rsi
               	jmp	<addr>
               	movq	%rdx, %rsi
               	jmp	<addr>
               	movq	%rdx, %rsi
               	jmp	<addr>
               	movq	%rdx, %rsi
               	jmp	<addr>
               	movq	$-0x1, %rsi
               	jmp	<addr>
               	movq	%rdx, %rsi
               	jmp	<addr>
               	movl	$0xd, %esi
               	movl	$0x11, %eax
               	nopl	(%rax,%rax)
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	$-0x2, %rdx
               	jmp	<addr>
               	movl	$0xd, %eax
               	movl	$0x11, %edx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	xorl	%esi, %esi
               	jmp	<addr>
               	movq	$-0x1, %rdx
               	movq	%rax, %rsi
               	jmp	<addr>
               	movl	$0xd, %esi
               	movl	$0x11, %edx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rsi
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rsi
               	movq	%rax, %r8
               	jmp	<addr>
               	movq	%rax, %rdx
               	movq	%rax, %r8
               	jmp	<addr>
               	movq	%rax, %rdx
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rdx
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rdx
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %r8
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %r8
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rsi
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rsi
               	movq	%rax, %rdx
               	jmp	<addr>
               	movl	$0xd, %edx
               	movl	$0x11, %esi
               	jmp	<addr>
               	movl	$0x1, %eax
               	nop
               	jmp	<addr>
               	movq	$-0x2, %rdx
               	jmp	<addr>
               	movl	$0xd, %eax
               	movl	$0x11, %edx
               	nopl	(%rax,%rax)
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rdx, %rsi
               	jmp	<addr>
               	movq	$-0x1, %rdx
               	movq	%rax, %rsi
               	nop
               	jmp	<addr>
               	movl	$0xd, %esi
               	movl	$0x11, %edx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rsi
               	nop
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movl	$0x1, %esi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movl	$0xd, %esi
               	movl	$0x11, %edx
               	jmp	<addr>
               	xorl	%eax, %eax
               	movl	$0x1, %ecx
               	movabsq	$-0x2eb506b7b9cbd8a0, %r11 # imm = 0xD14AF94846342760
               	movq	%rsi, %rdx
               	cmpq	%r11, %rsi
               	cmovneq	%rcx, %rax
               	retq
