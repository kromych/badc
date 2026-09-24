
pragma_pack_bitfield_layout.x64:	file format elf64-x86-64

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

<image_is>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	leaq	-0x90(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x8, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x90(%rbp), %rdi
               	movl	(%rdi), %eax
               	andq	$-0x40000000, %rax      # imm = 0xC0000000
               	orq	$0x3fffffff, %rax       # imm = 0x3FFFFFFF
               	movl	%eax, (%rdi)
               	movq	(%rdi), %rax
               	movabsq	$-0xfffffffc0000001, %r11 # imm = 0xF00000003FFFFFFF
               	andq	%r11, %rax
               	movabsq	$0xaaaaaaa80000000, %r11 # imm = 0xAAAAAAA80000000
               	orq	%r11, %rax
               	movq	%rax, (%rdi)
               	leaq	<rip>, %rsi
               	movl	$0x8, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	-0x90(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$0x3fffffff, %rcx       # imm = 0x3FFFFFFF
               	shlq	$0x22, %rcx
               	sarq	$0x22, %rcx
               	cmpl	$-0x1, %ecx
               	jne	<addr>
               	movq	(%rax), %rax
               	sarq	$0x1e, %rax
               	andq	$0x3fffffff, %rax       # imm = 0x3FFFFFFF
               	shlq	$0x22, %rax
               	sarq	$0x22, %rax
               	cmpl	$0xeaaaaaaa, %eax       # imm = 0xEAAAAAAA
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0x88(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x5, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x88(%rbp), %rdi
               	movb	$0x1, (%rdi)
               	movzwq	0x1(%rdi), %rax
               	andq	$-0x8000, %rax          # imm = 0x8000
               	orq	$0x7ffe, %rax           # imm = 0x7FFE
               	movw	%ax, 0x1(%rdi)
               	movw	$0x1234, 0x3(%rdi)      # imm = 0x1234
               	leaq	<rip>, %rsi
               	movl	$0x5, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	-0x88(%rbp), %rax
               	movsbq	(%rax), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movzwq	0x1(%rax), %rcx
               	andq	$0x7fff, %rcx           # imm = 0x7FFF
               	shlq	$0x31, %rcx
               	sarq	$0x31, %rcx
               	cmpl	$-0x2, %ecx
               	jne	<addr>
               	movswq	0x3(%rax), %rax
               	cmpl	$0x1234, %eax           # imm = 0x1234
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	-0x80(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0xa, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x80(%rbp), %rdi
               	movb	$0x1, (%rdi)
               	movq	0x1(%rdi), %rax
               	movabsq	$-0x1000000000000000, %r11 # imm = 0xF000000000000000
               	andq	%r11, %rax
               	movabsq	$0xffffffffffffff, %r11 # imm = 0xFFFFFFFFFFFFFF
               	orq	%r11, %rax
               	movq	%rax, 0x1(%rdi)
               	movb	$0x2, 0x9(%rdi)
               	leaq	<rip>, %rsi
               	movl	$0xa, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	-0x80(%rbp), %rax
               	movq	0x1(%rax), %rcx
               	movabsq	$0xfffffffffffffff, %r11 # imm = 0xFFFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	shlq	$0x4, %rcx
               	sarq	$0x4, %rcx
               	movabsq	$0xffffffffffffff, %r11 # imm = 0xFFFFFFFFFFFFFF
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movsbq	0x9(%rax), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movl	$0xf, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movl	(%rax), %ecx
               	andq	$0x3fffff, %rcx         # imm = 0x3FFFFF
               	cmpl	$0x79a, %ecx            # imm = 0x79A
               	jne	<addr>
               	movl	0x2(%rax), %ecx
               	sarq	$0x6, %rcx
               	andq	$0x7fffff, %rcx         # imm = 0x7FFFFF
               	shlq	$0x29, %rcx
               	sarq	$0x29, %rcx
               	cmpl	$0xfffff88f, %ecx       # imm = 0xFFFFF88F
               	jne	<addr>
               	movl	0x5(%rax), %ecx
               	sarq	$0x5, %rcx
               	andq	$0x3ffffff, %rcx        # imm = 0x3FFFFFF
               	cmpl	$0x13de, %ecx           # imm = 0x13DE
               	jne	<addr>
               	movzwq	0x8(%rax), %rcx
               	sarq	$0x7, %rcx
               	andq	$0x1f, %rcx
               	shlq	$0x3b, %rcx
               	sarq	$0x3b, %rcx
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	movl	0x9(%rax), %ecx
               	sarq	$0x4, %rcx
               	andq	$0xfffff, %rcx          # imm = 0xFFFFF
               	shlq	$0x2c, %rcx
               	sarq	$0x2c, %rcx
               	cmpl	$0x16a, %ecx            # imm = 0x16A
               	jne	<addr>
               	movl	0xb(%rax), %eax
               	sarq	$0x8, %rax
               	andq	$0xfffff, %rax          # imm = 0xFFFFF
               	cmpl	$0x141, %eax            # imm = 0x141
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	leaq	-0x70(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0xf, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x70(%rbp), %rdi
               	movl	(%rdi), %eax
               	andq	$-0x400000, %rax        # imm = 0xFFC00000
               	orq	$0x79a, %rax            # imm = 0x79A
               	movl	%eax, (%rdi)
               	movl	0x2(%rdi), %eax
               	andq	$-0x1fffffc1, %rax      # imm = 0xE000003F
               	orq	$0x1ffe23c0, %rax       # imm = 0x1FFE23C0
               	movl	%eax, 0x2(%rdi)
               	movl	0x5(%rdi), %eax
               	andq	$-0x7fffffe1, %rax      # imm = 0x8000001F
               	orq	$0x27bc0, %rax          # imm = 0x27BC0
               	movl	%eax, 0x5(%rdi)
               	movzwq	0x8(%rdi), %rax
               	andq	$-0xf81, %rax           # imm = 0xF07F
               	orq	$0x200, %rax            # imm = 0x200
               	movw	%ax, 0x8(%rdi)
               	movl	0x9(%rdi), %eax
               	andq	$-0xfffff1, %rax        # imm = 0xFF00000F
               	orq	$0x16a0, %rax           # imm = 0x16A0
               	movl	%eax, 0x9(%rdi)
               	movl	0xb(%rdi), %eax
               	andq	$-0xfffff01, %rax       # imm = 0xF00000FF
               	orq	$0x14100, %rax          # imm = 0x14100
               	movl	%eax, 0xb(%rdi)
               	leaq	<rip>, %rsi
               	movl	$0xf, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	leaq	-0x60(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0xa, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x60(%rbp), %rdi
               	movb	$0x1, (%rdi)
               	movl	0x1(%rdi), %eax
               	andq	$-0x40000000, %rax      # imm = 0xC0000000
               	orq	$0x3fffffff, %rax       # imm = 0x3FFFFFFF
               	movl	%eax, 0x1(%rdi)
               	movq	0x2(%rdi), %rax
               	movabsq	$-0xfffffffc00001, %r11 # imm = 0xFFF00000003FFFFF
               	andq	%r11, %rax
               	movabsq	$0xaaaaaaa800000, %r11  # imm = 0xAAAAAAA800000
               	orq	%r11, %rax
               	movq	%rax, 0x2(%rdi)
               	leaq	<rip>, %rsi
               	movl	$0xa, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movl	$0xa, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	-0x60(%rbp), %rax
               	movl	0x1(%rax), %eax
               	andq	$0x3fffffff, %rax       # imm = 0x3FFFFFFF
               	shlq	$0x22, %rax
               	sarq	$0x22, %rax
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	0x2(%rax), %rax
               	sarq	$0x16, %rax
               	andq	$0x3fffffff, %rax       # imm = 0x3FFFFFFF
               	shlq	$0x22, %rax
               	sarq	$0x22, %rax
               	cmpl	$0xeaaaaaaa, %eax       # imm = 0xEAAAAAAA
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x50(%rbp), %rdi
               	movb	$0x1, (%rdi)
               	movzwq	0x1(%rdi), %rax
               	andq	$-0x8000, %rax          # imm = 0x8000
               	orq	$0x7ffe, %rax           # imm = 0x7FFE
               	movw	%ax, 0x1(%rdi)
               	movb	$0x3, 0x3(%rdi)
               	leaq	<rip>, %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	-0x50(%rbp), %rax
               	movzwq	0x1(%rax), %rcx
               	andq	$0x7fff, %rcx           # imm = 0x7FFF
               	shlq	$0x31, %rcx
               	sarq	$0x31, %rcx
               	cmpl	$-0x2, %ecx
               	jne	<addr>
               	movsbq	0x3(%rax), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	leaq	-0x48(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0xc, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x48(%rbp), %rdi
               	movb	$0x1, (%rdi)
               	movq	0x1(%rdi), %rax
               	movabsq	$-0x1000000000000000, %r11 # imm = 0xF000000000000000
               	andq	%r11, %rax
               	movabsq	$0xffffffffffffff, %r11 # imm = 0xFFFFFFFFFFFFFF
               	orq	%r11, %rax
               	movq	%rax, 0x1(%rdi)
               	movb	$0x2, 0x9(%rdi)
               	leaq	<rip>, %rsi
               	movl	$0xc, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	-0x48(%rbp), %rax
               	movq	0x1(%rax), %rcx
               	movabsq	$0xfffffffffffffff, %r11 # imm = 0xFFFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	shlq	$0x4, %rcx
               	sarq	$0x4, %rcx
               	movabsq	$0xffffffffffffff, %r11 # imm = 0xFFFFFFFFFFFFFF
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movsbq	0x9(%rax), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	leaq	-0x38(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0xc, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x28(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0xc, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x18(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0xc, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x18(%rbp), %rdx
               	movb	$0x1, (%rdx)
               	movb	$0x1, (%rcx)
               	movb	$0x1, (%rax)
               	movl	$0x3fffffff, %esi       # imm = 0x3FFFFFFF
               	movl	0x4(%rdx), %edi
               	andq	$-0x40000000, %rdi      # imm = 0xC0000000
               	orq	%rsi, %rdi
               	movl	%edi, 0x4(%rdx)
               	movl	0x1(%rcx), %edx
               	andq	$-0x40000000, %rdx      # imm = 0xC0000000
               	orq	%rsi, %rdx
               	movl	%edx, 0x1(%rcx)
               	movl	0x1(%rax), %ecx
               	andq	$-0x40000000, %rcx      # imm = 0xC0000000
               	orq	%rsi, %rcx
               	movl	%ecx, 0x1(%rax)
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x18(%rbp), %rdx
               	movl	0x8(%rdx), %esi
               	andq	$-0x40000000, %rsi      # imm = 0xC0000000
               	orq	$0x2aaaaaaa, %rsi       # imm = 0x2AAAAAAA
               	movl	%esi, 0x8(%rdx)
               	movq	0x4(%rcx), %rdx
               	movabsq	$-0xfffffffc1, %rsi     # imm = 0xFFFFFFF00000003F
               	andq	%rdx, %rsi
               	movabsq	$0xaaaaaaa80, %rdx      # imm = 0xAAAAAAA80
               	orq	%rdx, %rsi
               	movq	%rsi, 0x4(%rcx)
               	movq	0x4(%rax), %rcx
               	movabsq	$-0xfffffffc1, %r11     # imm = 0xFFFFFFF00000003F
               	andq	%r11, %rcx
               	orq	%rdx, %rcx
               	movq	%rcx, 0x4(%rax)
               	leaq	-0x38(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0xc, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	-0x28(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0xc, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	-0x18(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0xc, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	leaq	-0x38(%rbp), %rax
               	movl	0x1(%rax), %eax
               	andq	$0x3fffffff, %rax       # imm = 0x3FFFFFFF
               	shlq	$0x22, %rax
               	sarq	$0x22, %rax
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	movq	0x4(%rax), %rax
               	sarq	$0x6, %rax
               	andq	$0x3fffffff, %rax       # imm = 0x3FFFFFFF
               	shlq	$0x22, %rax
               	sarq	$0x22, %rax
               	cmpl	$0xeaaaaaaa, %eax       # imm = 0xEAAAAAAA
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	movl	0x4(%rax), %ecx
               	andq	$0x3fffffff, %rcx       # imm = 0x3FFFFFFF
               	shlq	$0x22, %rcx
               	sarq	$0x22, %rcx
               	cmpl	$-0x1, %ecx
               	jne	<addr>
               	movl	0x8(%rax), %eax
               	andq	$0x3fffffff, %rax       # imm = 0x3FFFFFFF
               	shlq	$0x22, %rax
               	sarq	$0x22, %rax
               	cmpl	$0xeaaaaaaa, %eax       # imm = 0xEAAAAAAA
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movzwq	(%rax), %rax
               	andq	$0x7fff, %rax           # imm = 0x7FFF
               	shlq	$0x31, %rax
               	sarq	$0x31, %rax
               	cmpl	$0x6a, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzwq	(%rax), %rcx
               	andq	$0x7fff, %rcx           # imm = 0x7FFF
               	shlq	$0x31, %rcx
               	sarq	$0x31, %rcx
               	cmpl	$-0x1, %ecx
               	jne	<addr>
               	movzwq	0x2(%rax), %rax
               	andq	$0x7fff, %rax           # imm = 0x7FFF
               	shlq	$0x31, %rax
               	sarq	$0x31, %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	andq	$0x3fffff, %rax         # imm = 0x3FFFFF
               	shlq	$0x2a, %rax
               	sarq	$0x2a, %rax
               	cmpl	$0xfff0bdc0, %eax       # imm = 0xFFF0BDC0
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	leaq	-0x98(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movzbq	(%rcx), %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movb	%dl, 0x2(%rax)
               	popq	%rdx
               	movl	(%rax), %ecx
               	andq	$0x3fffff, %rcx         # imm = 0x3FFFFF
               	shlq	$0x2a, %rcx
               	sarq	$0x2a, %rcx
               	cmpl	$0xfff0bdc0, %ecx       # imm = 0xFFF0BDC0
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movzwq	(%rcx), %rcx
               	andq	$0x7fff, %rcx           # imm = 0x7FFF
               	shlq	$0x31, %rcx
               	sarq	$0x31, %rcx
               	cmpl	$-0x3, %ecx
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	movl	(%rax), %ecx
               	andq	$-0x400000, %rcx        # imm = 0xFFC00000
               	orq	$0xf4240, %rcx          # imm = 0xF4240
               	movl	%ecx, (%rax)
               	movq	%rcx, %rax
               	andq	$0x3fffff, %rax         # imm = 0x3FFFFF
               	shlq	$0x2a, %rax
               	sarq	$0x2a, %rax
               	cmpl	$0xf4240, %eax          # imm = 0xF4240
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x2, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	movzwq	(%rax), %rax
               	andq	$0x7fff, %rax           # imm = 0x7FFF
               	shlq	$0x31, %rax
               	sarq	$0x31, %rax
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x2, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x8(%rbp), %rdi
               	movzwq	(%rdi), %rax
               	andq	$-0x8000, %rax          # imm = 0x8000
               	orq	$0x7ffd, %rax           # imm = 0x7FFD
               	movw	%ax, (%rdi)
               	leaq	<rip>, %rsi
               	movl	$0x2, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rcx
               	andq	$0x7fff, %rcx           # imm = 0x7FFF
               	shlq	$0x31, %rcx
               	sarq	$0x31, %rcx
               	cmpl	$-0x3, %ecx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
