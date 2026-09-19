
switch_jump_table_phi_join.x64:	file format elf64-x86-64

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
               	xorl	%esi, %esi
               	movq	$-0x2, %rdx
               	movq	$-0x1, %rax
               	xorl	%ecx, %ecx
               	imulq	$0x21, %rsi, %rdi
               	cmpq	$0xc, %rdx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdx,8), %r10
               	jmpq	*%r10
               	leaq	0x2(%rcx), %rsi
               	xchgq	%rsi, %rcx
               	addq	%rcx, %rsi
               	leaq	(%rcx,%rcx,2), %rcx
               	subq	%rcx, %rsi
               	addq	%rsi, %rcx
               	shlq	%rsi
               	decq	%rcx
               	addq	$0x7, %rsi
               	addq	%rsi, %rcx
               	imulq	$0x1f, %rsi, %rsi
               	addq	%rsi, %rcx
               	leaq	(%rdi,%rcx), %rsi
               	movl	$0x1, %ecx
               	imulq	$0x21, %rsi, %rdi
               	cmpq	$0xc, %rdx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdx,8), %r10
               	jmpq	*%r10
               	xorl	%esi, %esi
               	leaq	0x2(%rsi), %rcx
               	addq	%rcx, %rsi
               	leaq	(%rcx,%rcx,2), %rcx
               	subq	%rcx, %rsi
               	addq	%rsi, %rcx
               	shlq	%rsi
               	decq	%rcx
               	addq	$0x7, %rsi
               	addq	%rsi, %rcx
               	imulq	$0x1f, %rsi, %rsi
               	addq	%rsi, %rcx
               	leaq	(%rdi,%rcx), %rsi
               	movl	$0x2, %ecx
               	imulq	$0x21, %rsi, %rsi
               	cmpq	$0xc, %rdx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdx,8), %r10
               	jmpq	*%r10
               	xorl	%eax, %eax
               	leaq	0x2(%rax), %rcx
               	addq	%rcx, %rax
               	leaq	(%rcx,%rcx,2), %rcx
               	subq	%rcx, %rax
               	addq	%rax, %rcx
               	shlq	%rax
               	decq	%rcx
               	addq	$0x7, %rax
               	addq	%rax, %rcx
               	imulq	$0x1f, %rax, %rax
               	addq	%rcx, %rax
               	leaq	(%rsi,%rax), %rcx
               	xorl	%eax, %eax
               	imulq	$0x21, %rcx, %r8
               	cmpq	$0xc, %rdx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdx,8), %r10
               	jmpq	*%r10
               	movl	$0x1, %ecx
               	leaq	0x2(%rcx), %rsi
               	leaq	(%rcx,%rsi), %rdi
               	leaq	(%rsi,%rsi,2), %rcx
               	movq	%rdi, %rsi
               	subq	%rcx, %rsi
               	addq	%rsi, %rcx
               	shlq	%rsi
               	leaq	-0x1(%rcx), %rdi
               	leaq	0x7(%rsi), %rcx
               	leaq	(%rdi,%rcx), %rsi
               	imulq	$0x1f, %rcx, %rcx
               	addq	%rsi, %rcx
               	leaq	(%r8,%rcx), %rsi
               	movl	$0x1, %ecx
               	imulq	$0x21, %rsi, %rdi
               	cmpq	$0xc, %rdx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdx,8), %r10
               	jmpq	*%r10
               	leaq	0x2(%rcx), %rsi
               	xchgq	%rsi, %rcx
               	addq	%rcx, %rsi
               	leaq	(%rcx,%rcx,2), %rcx
               	subq	%rcx, %rsi
               	addq	%rsi, %rcx
               	shlq	%rsi
               	decq	%rcx
               	addq	$0x7, %rsi
               	addq	%rsi, %rcx
               	imulq	$0x1f, %rsi, %rsi
               	addq	%rsi, %rcx
               	leaq	(%rdi,%rcx), %rsi
               	movl	$0x2, %ecx
               	imulq	$0x21, %rsi, %rsi
               	cmpq	$0xc, %rdx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdx,8), %r10
               	jmpq	*%r10
               	movl	$0x1, %eax
               	leaq	0x2(%rax), %rcx
               	addq	%rcx, %rax
               	leaq	(%rcx,%rcx,2), %rcx
               	subq	%rcx, %rax
               	addq	%rax, %rcx
               	shlq	%rax
               	decq	%rcx
               	addq	$0x7, %rax
               	addq	%rax, %rcx
               	imulq	$0x1f, %rax, %rax
               	addq	%rcx, %rax
               	addq	%rax, %rsi
               	movl	$0x1, %ecx
               	xorl	%eax, %eax
               	imulq	$0x21, %rsi, %rdi
               	cmpq	$0xc, %rdx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdx,8), %r10
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
               	imulq	$0x21, %rax, %r8
               	cmpq	$0xc, %rdx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdx,8), %r10
               	jmpq	*%r10
               	movl	$0x2, %eax
               	leaq	0x2(%rax), %rsi
               	leaq	(%rax,%rsi), %rdi
               	leaq	(%rsi,%rsi,2), %rax
               	movq	%rdi, %rsi
               	subq	%rax, %rsi
               	addq	%rsi, %rax
               	shlq	%rsi
               	leaq	-0x1(%rax), %rdi
               	leaq	0x7(%rsi), %rax
               	leaq	(%rdi,%rax), %rsi
               	imulq	$0x1f, %rax, %rax
               	addq	%rsi, %rax
               	leaq	(%r8,%rax), %rsi
               	movl	$0x2, %eax
               	imulq	$0x21, %rsi, %rdi
               	cmpq	$0xc, %rdx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdx,8), %r10
               	jmpq	*%r10
               	movq	%rax, %rcx
               	leaq	0x2(%rcx), %rsi
               	addq	%rsi, %rcx
               	leaq	(%rsi,%rsi,2), %rsi
               	subq	%rsi, %rcx
               	addq	%rcx, %rsi
               	shlq	%rcx
               	decq	%rsi
               	addq	$0x7, %rcx
               	addq	%rcx, %rsi
               	imulq	$0x1f, %rcx, %rcx
               	addq	%rsi, %rcx
               	leaq	(%rdi,%rcx), %rsi
               	xorl	%ecx, %ecx
               	imulq	$0x21, %rsi, %rdi
               	cmpq	$0xc, %rdx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdx,8), %r10
               	jmpq	*%r10
               	movl	$0x3, %esi
               	leaq	0x2(%rsi), %rcx
               	addq	%rcx, %rsi
               	leaq	(%rcx,%rcx,2), %rcx
               	subq	%rcx, %rsi
               	addq	%rsi, %rcx
               	shlq	%rsi
               	decq	%rcx
               	addq	$0x7, %rsi
               	addq	%rsi, %rcx
               	imulq	$0x1f, %rsi, %rsi
               	addq	%rsi, %rcx
               	leaq	(%rdi,%rcx), %rsi
               	movl	$0x1, %ecx
               	imulq	$0x21, %rsi, %rdi
               	cmpq	$0xc, %rdx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdx,8), %r10
               	jmpq	*%r10
               	movl	$0x3, %esi
               	leaq	0x2(%rsi), %rcx
               	addq	%rcx, %rsi
               	leaq	(%rcx,%rcx,2), %rcx
               	subq	%rcx, %rsi
               	addq	%rsi, %rcx
               	shlq	%rsi
               	decq	%rcx
               	addq	$0x7, %rsi
               	addq	%rsi, %rcx
               	imulq	$0x1f, %rsi, %rsi
               	addq	%rsi, %rcx
               	leaq	(%rdi,%rcx), %rsi
               	movl	$0x2, %ecx
               	imulq	$0x21, %rsi, %rsi
               	cmpq	$0xc, %rdx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdx,8), %r10
               	jmpq	*%r10
               	movl	$0x3, %eax
               	leaq	0x2(%rax), %rcx
               	addq	%rcx, %rax
               	leaq	(%rcx,%rcx,2), %rcx
               	subq	%rcx, %rax
               	addq	%rax, %rcx
               	shlq	%rax
               	decq	%rcx
               	addq	$0x7, %rax
               	addq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	$-0x2, %rax
               	jmp	<addr>
               	movq	$-0x2, %rcx
               	jmp	<addr>
               	movl	$0xd, %eax
               	movl	$0x11, %ecx
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
               	movq	$-0x1, %rcx
               	movq	%rax, %rsi
               	jmp	<addr>
               	movl	$0xd, %esi
               	movl	$0x11, %ecx
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
               	jmp	<addr>
               	movl	$0xd, %esi
               	movl	$0x11, %ecx
               	jmp	<addr>
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
               	movq	$-0x1, %rcx
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	$-0x2, %rsi
               	jmp	<addr>
               	movl	$0xd, %ecx
               	movl	$0x11, %esi
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%rcx, %rsi
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%rcx, %rsi
               	movq	%rcx, %rdi
               	jmp	<addr>
               	movq	%rcx, %rax
               	movq	%rcx, %rdi
               	jmp	<addr>
               	movq	%rcx, %rax
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	%rcx, %rax
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	%rcx, %rax
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	%rcx, %rdi
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	%rcx, %rdi
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	$-0x1, %rax
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	$-0x1, %rsi
               	movq	%rcx, %rax
               	jmp	<addr>
               	movl	$0xd, %eax
               	movl	$0x11, %esi
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	$-0x1, %rsi
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movl	$0xd, %esi
               	movl	$0x11, %eax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	$-0x2, %rcx
               	jmp	<addr>
               	movl	$0xd, %eax
               	movl	$0x11, %ecx
               	jmp	<addr>
               	movq	%rax, %rcx
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
               	movq	$-0x1, %rcx
               	movq	%rax, %rsi
               	jmp	<addr>
               	movl	$0xd, %esi
               	movl	$0x11, %ecx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rsi
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rsi
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rcx
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rcx
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rcx
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rcx
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rdi
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rdi
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rsi
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rsi
               	movq	%rax, %rcx
               	jmp	<addr>
               	movl	$0xd, %ecx
               	movl	$0x11, %esi
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	movq	$-0x2, %rcx
               	jmp	<addr>
               	movl	$0xd, %eax
               	movl	$0x11, %ecx
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
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	$-0x1, %rcx
               	movq	%rax, %rsi
               	jmp	<addr>
               	movl	$0xd, %esi
               	movl	$0x11, %ecx
               	jmp	<addr>
               	movq	%rax, %rcx
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
               	movl	$0x1, %esi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movl	$0xd, %esi
               	movl	$0x11, %ecx
               	jmp	<addr>
               	imulq	$0x1f, %rax, %rax
               	addq	%rcx, %rax
               	addq	%rax, %rsi
               	incq	%rdx
               	cmpl	$0xe, %edx
               	jl	<addr>
               	movabsq	$-0x2eb506b7b9cbd8a0, %r11 # imm = 0xD14AF94846342760
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
