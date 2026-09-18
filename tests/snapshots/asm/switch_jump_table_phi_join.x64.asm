
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
               	xorq	%rdx, %rdx
               	movabsq	$-0x2, %rsi
               	jmp	<addr>
               	movabsq	$-0x1, %rax
               	xorq	%rcx, %rcx
               	imulq	$0x21, %rdx, %r8
               	movslq	%esi, %rdx
               	cmpq	$0xc, %rdx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdx,8), %r10
               	jmpq	*%r10
               	leaq	0x2(%rcx), %rdi
               	xchgq	%rdi, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rcx,%rcx,2), %rcx
               	subq	%rcx, %rdi
               	addq	%rdi, %rcx
               	shlq	%rdi
               	decq	%rcx
               	addq	$0x7, %rdi
               	addq	%rdi, %rcx
               	imulq	$0x1f, %rdi, %rdi
               	addq	%rdi, %rcx
               	leaq	(%r8,%rcx), %rdi
               	movl	$0x1, %ecx
               	imulq	$0x21, %rdi, %r8
               	cmpq	$0xc, %rdx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdx,8), %r10
               	jmpq	*%r10
               	xorq	%rdi, %rdi
               	leaq	0x2(%rdi), %rcx
               	addq	%rcx, %rdi
               	leaq	(%rcx,%rcx,2), %rcx
               	subq	%rcx, %rdi
               	addq	%rdi, %rcx
               	shlq	%rdi
               	decq	%rcx
               	addq	$0x7, %rdi
               	addq	%rdi, %rcx
               	imulq	$0x1f, %rdi, %rdi
               	addq	%rdi, %rcx
               	leaq	(%r8,%rcx), %rdi
               	movl	$0x2, %ecx
               	imulq	$0x21, %rdi, %rdi
               	cmpq	$0xc, %rdx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdx,8), %r10
               	jmpq	*%r10
               	xorq	%rax, %rax
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
               	leaq	(%rdi,%rax), %rcx
               	xorq	%rax, %rax
               	imulq	$0x21, %rcx, %r9
               	cmpq	$0xc, %rdx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdx,8), %r10
               	jmpq	*%r10
               	movl	$0x1, %ecx
               	leaq	0x2(%rcx), %rdi
               	leaq	(%rcx,%rdi), %r8
               	leaq	(%rdi,%rdi,2), %rcx
               	movq	%r8, %rdi
               	subq	%rcx, %rdi
               	addq	%rdi, %rcx
               	shlq	%rdi
               	leaq	-0x1(%rcx), %r8
               	leaq	0x7(%rdi), %rcx
               	leaq	(%r8,%rcx), %rdi
               	imulq	$0x1f, %rcx, %rcx
               	addq	%rdi, %rcx
               	leaq	(%r9,%rcx), %rdi
               	movl	$0x1, %ecx
               	imulq	$0x21, %rdi, %r8
               	cmpq	$0xc, %rdx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdx,8), %r10
               	jmpq	*%r10
               	leaq	0x2(%rcx), %rdi
               	xchgq	%rdi, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rcx,%rcx,2), %rcx
               	subq	%rcx, %rdi
               	addq	%rdi, %rcx
               	shlq	%rdi
               	decq	%rcx
               	addq	$0x7, %rdi
               	addq	%rdi, %rcx
               	imulq	$0x1f, %rdi, %rdi
               	addq	%rdi, %rcx
               	leaq	(%r8,%rcx), %rdi
               	movl	$0x2, %ecx
               	imulq	$0x21, %rdi, %rdi
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
               	addq	%rax, %rdi
               	movl	$0x1, %eax
               	xorq	%rcx, %rcx
               	imulq	$0x21, %rdi, %r8
               	cmpq	$0xc, %rdx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdx,8), %r10
               	jmpq	*%r10
               	movl	$0x2, %edi
               	leaq	0x2(%rdi), %rcx
               	addq	%rcx, %rdi
               	leaq	(%rcx,%rcx,2), %rcx
               	subq	%rcx, %rdi
               	addq	%rdi, %rcx
               	shlq	%rdi
               	decq	%rcx
               	addq	$0x7, %rdi
               	addq	%rdi, %rcx
               	imulq	$0x1f, %rdi, %rdi
               	addq	%rdi, %rcx
               	leaq	(%r8,%rcx), %rdi
               	movl	$0x1, %ecx
               	imulq	$0x21, %rdi, %r8
               	cmpq	$0xc, %rdx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdx,8), %r10
               	jmpq	*%r10
               	movl	$0x2, %edi
               	leaq	0x2(%rdi), %rcx
               	addq	%rcx, %rdi
               	leaq	(%rcx,%rcx,2), %rcx
               	subq	%rcx, %rdi
               	addq	%rdi, %rcx
               	shlq	%rdi
               	decq	%rcx
               	addq	$0x7, %rdi
               	addq	%rdi, %rcx
               	imulq	$0x1f, %rdi, %rdi
               	addq	%rdi, %rcx
               	leaq	(%r8,%rcx), %rdi
               	movl	$0x2, %ecx
               	imulq	$0x21, %rdi, %rdi
               	cmpq	$0xc, %rdx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdx,8), %r10
               	jmpq	*%r10
               	movq	%rcx, %rax
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
               	addq	%rax, %rdi
               	movl	$0x2, %eax
               	xorq	%rcx, %rcx
               	imulq	$0x21, %rdi, %r8
               	cmpq	$0xc, %rdx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdx,8), %r10
               	jmpq	*%r10
               	movl	$0x3, %edi
               	leaq	0x2(%rdi), %rcx
               	addq	%rcx, %rdi
               	leaq	(%rcx,%rcx,2), %rcx
               	subq	%rcx, %rdi
               	addq	%rdi, %rcx
               	shlq	%rdi
               	decq	%rcx
               	addq	$0x7, %rdi
               	addq	%rdi, %rcx
               	imulq	$0x1f, %rdi, %rdi
               	addq	%rdi, %rcx
               	leaq	(%r8,%rcx), %rdi
               	movl	$0x1, %ecx
               	imulq	$0x21, %rdi, %r8
               	cmpq	$0xc, %rdx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdx,8), %r10
               	jmpq	*%r10
               	movl	$0x3, %edi
               	leaq	0x2(%rdi), %rcx
               	addq	%rcx, %rdi
               	leaq	(%rcx,%rcx,2), %rcx
               	subq	%rcx, %rdi
               	addq	%rdi, %rcx
               	shlq	%rdi
               	decq	%rcx
               	addq	$0x7, %rdi
               	addq	%rdi, %rcx
               	imulq	$0x1f, %rdi, %rdi
               	addq	%rdi, %rcx
               	leaq	(%r8,%rcx), %rdi
               	movl	$0x2, %ecx
               	imulq	$0x21, %rdi, %rdi
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
               	imulq	$0x1f, %rax, %rax
               	addq	%rcx, %rax
               	leaq	(%rdi,%rax), %rdx
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
               	movabsq	$-0x2, %rax
               	jmp	<addr>
               	movabsq	$-0x2, %rcx
               	jmp	<addr>
               	movl	$0xd, %eax
               	movl	$0x11, %ecx
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movabsq	$-0x2, %rdi
               	jmp	<addr>
               	movabsq	$-0x1, %rcx
               	movq	%rax, %rdi
               	jmp	<addr>
               	movl	$0xd, %edi
               	movl	$0x11, %ecx
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movabsq	$-0x2, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movl	$0xd, %edi
               	movl	$0x11, %ecx
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
               	movabsq	$-0x1, %rax
               	jmp	<addr>
               	movabsq	$-0x2, %rcx
               	jmp	<addr>
               	movl	$0xd, %eax
               	movl	$0x11, %ecx
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movabsq	$-0x1, %rdi
               	jmp	<addr>
               	movabsq	$-0x1, %rcx
               	movq	%rax, %rdi
               	jmp	<addr>
               	movl	$0xd, %edi
               	movl	$0x11, %ecx
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movabsq	$-0x1, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movl	$0xd, %edi
               	movl	$0x11, %ecx
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
               	xorq	%rax, %rax
               	jmp	<addr>
               	movabsq	$-0x2, %rcx
               	jmp	<addr>
               	movl	$0xd, %eax
               	movl	$0x11, %ecx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	movabsq	$-0x1, %rcx
               	movq	%rax, %rdi
               	jmp	<addr>
               	movl	$0xd, %edi
               	movl	$0x11, %ecx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rdi
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rdi
               	movq	%rax, %r8
               	jmp	<addr>
               	movq	%rax, %rcx
               	movq	%rax, %r8
               	jmp	<addr>
               	movq	%rax, %rcx
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rcx
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rcx
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %r8
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %r8
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rdi
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rdi
               	movq	%rax, %rcx
               	jmp	<addr>
               	movl	$0xd, %ecx
               	movl	$0x11, %edi
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
               	movabsq	$-0x2, %rcx
               	jmp	<addr>
               	movl	$0xd, %eax
               	movl	$0x11, %ecx
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rcx, %rdi
               	jmp	<addr>
               	movabsq	$-0x1, %rcx
               	movq	%rax, %rdi
               	jmp	<addr>
               	movl	$0xd, %edi
               	movl	$0x11, %ecx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movl	$0x1, %edi
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movl	$0xd, %edi
               	movl	$0x11, %ecx
               	jmp	<addr>
               	incq	%rsi
               	cmpl	$0xe, %esi
               	jl	<addr>
               	movabsq	$-0x2eb506b7b9cbd8a0, %r11 # imm = 0xD14AF94846342760
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
