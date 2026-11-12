
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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	leaq	-0x90(%rbp), %rdi
               	movb	$0x0, -0x90(%rbp)
               	movb	$0x0, -0x8f(%rbp)
               	movb	$0x0, -0x8e(%rbp)
               	movb	$0x0, -0x8d(%rbp)
               	movb	$0x0, -0x8c(%rbp)
               	movb	$0x0, -0x8b(%rbp)
               	movb	$0x0, -0x8a(%rbp)
               	movb	$0x0, -0x89(%rbp)
               	movl	-0x90(%rbp), %eax
               	andq	$-0x40000000, %rax      # imm = 0xC0000000
               	orq	$0x3fffffff, %rax       # imm = 0x3FFFFFFF
               	movl	%eax, -0x90(%rbp)
               	movq	-0x90(%rbp), %rax
               	movabsq	$-0xfffffffc0000001, %r11 # imm = 0xF00000003FFFFFFF
               	andq	%r11, %rax
               	movabsq	$0xaaaaaaa80000000, %r11 # imm = 0xAAAAAAA80000000
               	orq	%r11, %rax
               	movq	%rax, -0x90(%rbp)
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x8, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x90(%rbp), %eax
               	shlq	$0x22, %rax
               	sarq	$0x22, %rax
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	movq	-0x90(%rbp), %rax
               	sarq	$0x1e, %rax
               	shlq	$0x22, %rax
               	sarq	$0x22, %rax
               	cmpl	$0xeaaaaaaa, %eax       # imm = 0xEAAAAAAA
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0x88(%rbp), %rdi
               	movb	$0x0, -0x88(%rbp)
               	movb	$0x0, -0x87(%rbp)
               	movb	$0x0, -0x86(%rbp)
               	movb	$0x0, -0x85(%rbp)
               	movb	$0x0, -0x84(%rbp)
               	movb	$0x1, -0x88(%rbp)
               	movzwq	-0x87(%rbp), %rax
               	andq	$-0x8000, %rax          # imm = 0x8000
               	orq	$0x7ffe, %rax           # imm = 0x7FFE
               	movw	%ax, -0x87(%rbp)
               	movw	$0x1234, -0x85(%rbp)    # imm = 0x1234
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x5, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movsbq	-0x88(%rbp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movzwq	-0x87(%rbp), %rax
               	shlq	$0x31, %rax
               	sarq	$0x31, %rax
               	cmpl	$-0x2, %eax
               	jne	<addr>
               	movswq	-0x85(%rbp), %rax
               	cmpl	$0x1234, %eax           # imm = 0x1234
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	-0x70(%rbp), %rdi
               	movb	$0x0, -0x70(%rbp)
               	movb	$0x0, -0x6f(%rbp)
               	movb	$0x0, -0x6e(%rbp)
               	movb	$0x0, -0x6d(%rbp)
               	movb	$0x0, -0x6c(%rbp)
               	movb	$0x0, -0x6b(%rbp)
               	movb	$0x0, -0x6a(%rbp)
               	movb	$0x0, -0x69(%rbp)
               	movb	$0x0, -0x68(%rbp)
               	movb	$0x0, -0x67(%rbp)
               	movb	$0x1, -0x70(%rbp)
               	movq	-0x6f(%rbp), %rax
               	movabsq	$-0x1000000000000000, %r11 # imm = 0xF000000000000000
               	andq	%r11, %rax
               	movabsq	$0xffffffffffffff, %r11 # imm = 0xFFFFFFFFFFFFFF
               	orq	%r11, %rax
               	movq	%rax, -0x6f(%rbp)
               	movb	$0x2, -0x67(%rbp)
               	leaq	<rip>, %rsi # <addr>
               	movl	$0xa, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x6f(%rbp), %rax
               	shlq	$0x4, %rax
               	sarq	$0x4, %rax
               	movabsq	$0xffffffffffffff, %r11 # imm = 0xFFFFFFFFFFFFFF
               	cmpq	%r11, %rax
               	jne	<addr>
               	movsbq	-0x67(%rbp), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movl	$0xf, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	andq	$0x3fffff, %rax         # imm = 0x3FFFFF
               	cmpl	$0x79a, %eax            # imm = 0x79A
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	sarq	$0x6, %rax
               	shlq	$0x29, %rax
               	sarq	$0x29, %rax
               	cmpl	$0xfffff88f, %eax       # imm = 0xFFFFF88F
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	sarq	$0x5, %rax
               	andq	$0x3ffffff, %rax        # imm = 0x3FFFFFF
               	cmpl	$0x13de, %eax           # imm = 0x13DE
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	sarq	$0x7, %rax
               	shlq	$0x3b, %rax
               	sarq	$0x3b, %rax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	sarq	$0x4, %rax
               	shlq	$0x2c, %rax
               	sarq	$0x2c, %rax
               	cmpl	$0x16a, %eax            # imm = 0x16A
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	sarq	$0x8, %rax
               	andq	$0xfffff, %rax          # imm = 0xFFFFF
               	cmpl	$0x141, %eax            # imm = 0x141
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movb	$0x0, -0x60(%rbp)
               	movb	$0x0, -0x5f(%rbp)
               	movb	$0x0, -0x5e(%rbp)
               	movb	$0x0, -0x5d(%rbp)
               	movb	$0x0, -0x5c(%rbp)
               	movb	$0x0, -0x5b(%rbp)
               	movb	$0x0, -0x5a(%rbp)
               	movb	$0x0, -0x59(%rbp)
               	movb	$0x0, -0x58(%rbp)
               	movb	$0x0, -0x57(%rbp)
               	movb	$0x0, -0x56(%rbp)
               	movb	$0x0, -0x55(%rbp)
               	movb	$0x0, -0x54(%rbp)
               	movb	$0x0, -0x53(%rbp)
               	movb	$0x0, -0x52(%rbp)
               	movl	-0x60(%rbp), %eax
               	andq	$-0x400000, %rax        # imm = 0xFFC00000
               	orq	$0x79a, %rax            # imm = 0x79A
               	movl	%eax, -0x60(%rbp)
               	movl	-0x5e(%rbp), %eax
               	andq	$-0x1fffffc1, %rax      # imm = 0xE000003F
               	orq	$0x1ffe23c0, %rax       # imm = 0x1FFE23C0
               	movl	%eax, -0x5e(%rbp)
               	movl	-0x5b(%rbp), %eax
               	andq	$-0x7fffffe1, %rax      # imm = 0x8000001F
               	orq	$0x27bc0, %rax          # imm = 0x27BC0
               	movl	%eax, -0x5b(%rbp)
               	movzwq	-0x58(%rbp), %rax
               	andq	$-0xf81, %rax           # imm = 0xF07F
               	orq	$0x200, %rax            # imm = 0x200
               	movw	%ax, -0x58(%rbp)
               	movl	-0x57(%rbp), %eax
               	andq	$-0xfffff1, %rax        # imm = 0xFF00000F
               	orq	$0x16a0, %rax           # imm = 0x16A0
               	movl	%eax, -0x57(%rbp)
               	movl	-0x55(%rbp), %eax
               	andq	$-0xfffff01, %rax       # imm = 0xF00000FF
               	orq	$0x14100, %rax          # imm = 0x14100
               	movl	%eax, -0x55(%rbp)
               	leaq	-0x60(%rbp), %rdi
               	leaq	<rip>, %rsi # <addr>
               	movl	$0xf, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %rdi
               	movw	$0x0, -0x50(%rbp)
               	movw	$0x0, -0x4e(%rbp)
               	movw	$0x0, -0x4c(%rbp)
               	movw	$0x0, -0x4a(%rbp)
               	movw	$0x0, -0x48(%rbp)
               	movb	$0x1, -0x50(%rbp)
               	movl	-0x4f(%rbp), %eax
               	andq	$-0x40000000, %rax      # imm = 0xC0000000
               	orq	$0x3fffffff, %rax       # imm = 0x3FFFFFFF
               	movl	%eax, -0x4f(%rbp)
               	movq	-0x4e(%rbp), %rax
               	movabsq	$-0xfffffffc00001, %r11 # imm = 0xFFF00000003FFFFF
               	andq	%r11, %rax
               	movabsq	$0xaaaaaaa800000, %r11  # imm = 0xAAAAAAA800000
               	orq	%r11, %rax
               	movq	%rax, -0x4e(%rbp)
               	leaq	<rip>, %rsi # <addr>
               	movl	$0xa, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movl	$0xa, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x4f(%rbp), %eax
               	shlq	$0x22, %rax
               	sarq	$0x22, %rax
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	sarq	$0x16, %rax
               	shlq	$0x22, %rax
               	sarq	$0x22, %rax
               	cmpl	$0xeaaaaaaa, %eax       # imm = 0xEAAAAAAA
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	leaq	-0x80(%rbp), %rdi
               	movw	$0x0, -0x80(%rbp)
               	movw	$0x0, -0x7e(%rbp)
               	movb	$0x1, -0x80(%rbp)
               	movzwq	-0x7f(%rbp), %rax
               	andq	$-0x8000, %rax          # imm = 0x8000
               	orq	$0x7ffe, %rax           # imm = 0x7FFE
               	movw	%ax, -0x7f(%rbp)
               	movb	$0x3, -0x7d(%rbp)
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzwq	-0x7f(%rbp), %rax
               	shlq	$0x31, %rax
               	sarq	$0x31, %rax
               	cmpl	$-0x2, %eax
               	jne	<addr>
               	movsbq	-0x7d(%rbp), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x0, -0x40(%rbp)
               	movl	$0x0, -0x3c(%rbp)
               	movl	$0x0, -0x38(%rbp)
               	movb	$0x1, -0x40(%rbp)
               	movq	-0x3f(%rbp), %rax
               	movabsq	$-0x1000000000000000, %r11 # imm = 0xF000000000000000
               	andq	%r11, %rax
               	movabsq	$0xffffffffffffff, %r11 # imm = 0xFFFFFFFFFFFFFF
               	orq	%r11, %rax
               	movq	%rax, -0x3f(%rbp)
               	movb	$0x2, -0x37(%rbp)
               	leaq	<rip>, %rsi # <addr>
               	movl	$0xc, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x3f(%rbp), %rax
               	shlq	$0x4, %rax
               	sarq	$0x4, %rax
               	movabsq	$0xffffffffffffff, %r11 # imm = 0xFFFFFFFFFFFFFF
               	cmpq	%r11, %rax
               	jne	<addr>
               	movsbq	-0x37(%rbp), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	movl	$0x0, -0x30(%rbp)
               	movl	$0x0, -0x2c(%rbp)
               	movl	$0x0, -0x28(%rbp)
               	movl	$0x0, -0x20(%rbp)
               	movl	$0x0, -0x1c(%rbp)
               	movl	$0x0, -0x18(%rbp)
               	movl	$0x0, -0x10(%rbp)
               	movl	$0x0, -0xc(%rbp)
               	movl	$0x0, -0x8(%rbp)
               	movb	$0x1, -0x10(%rbp)
               	movb	$0x1, -0x20(%rbp)
               	movb	$0x1, -0x30(%rbp)
               	movl	$0x3fffffff, %eax       # imm = 0x3FFFFFFF
               	movl	%eax, -0xc(%rbp)
               	movl	-0x1f(%rbp), %ecx
               	andq	$-0x40000000, %rcx      # imm = 0xC0000000
               	orq	%rax, %rcx
               	movl	%ecx, -0x1f(%rbp)
               	movl	-0x2f(%rbp), %ecx
               	andq	$-0x40000000, %rcx      # imm = 0xC0000000
               	orq	%rcx, %rax
               	movl	%eax, -0x2f(%rbp)
               	leaq	-0x30(%rbp), %rdi
               	movl	$0x2aaaaaaa, -0x8(%rbp) # imm = 0x2AAAAAAA
               	movq	-0x1c(%rbp), %rax
               	movabsq	$-0xfffffffc1, %rcx     # imm = 0xFFFFFFF00000003F
               	andq	%rax, %rcx
               	movabsq	$0xaaaaaaa80, %rax      # imm = 0xAAAAAAA80
               	orq	%rax, %rcx
               	movq	%rcx, -0x1c(%rbp)
               	movq	-0x2c(%rbp), %rcx
               	movabsq	$-0xfffffffc1, %r11     # imm = 0xFFFFFFF00000003F
               	andq	%r11, %rcx
               	orq	%rcx, %rax
               	movq	%rax, -0x2c(%rbp)
               	leaq	<rip>, %rsi # <addr>
               	movl	$0xc, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rdi
               	leaq	<rip>, %rsi # <addr>
               	movl	$0xc, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rdi
               	leaq	<rip>, %rsi # <addr>
               	movl	$0xc, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	movl	-0x2f(%rbp), %eax
               	shlq	$0x22, %rax
               	sarq	$0x22, %rax
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	movq	-0x1c(%rbp), %rax
               	sarq	$0x6, %rax
               	shlq	$0x22, %rax
               	sarq	$0x22, %rax
               	cmpl	$0xeaaaaaaa, %eax       # imm = 0xEAAAAAAA
               	jne	<addr>
               	movl	-0xc(%rbp), %eax
               	shlq	$0x22, %rax
               	sarq	$0x22, %rax
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	movl	-0x8(%rbp), %eax
               	shlq	$0x22, %rax
               	sarq	$0x22, %rax
               	cmpl	$0xeaaaaaaa, %eax       # imm = 0xEAAAAAAA
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	movzwq	<rip>, %rax # <addr>
               	shlq	$0x31, %rax
               	sarq	$0x31, %rax
               	cmpl	$0x6a, %eax
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	shlq	$0x31, %rax
               	sarq	$0x31, %rax
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	shlq	$0x31, %rax
               	sarq	$0x31, %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	movzwq	<rip>, %rax # <addr>
               	movzbq	<rip>, %rcx # <addr>
               	shlq	$0x10, %rcx
               	orq	%rcx, %rax
               	shlq	$0x2a, %rax
               	sarq	$0x2a, %rax
               	cmpl	$0xfff0bdc0, %eax       # imm = 0xFFF0BDC0
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	movzwq	<rip>, %rax # <addr>
               	shlq	$0x31, %rax
               	sarq	$0x31, %rax
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x2, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	shlq	$0x31, %rax
               	sarq	$0x31, %rax
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	leaq	-0x78(%rbp), %rdi
               	movw	$0x0, -0x78(%rbp)
               	movw	$0x7ffd, -0x78(%rbp)    # imm = 0x7FFD
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x2, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzwq	-0x78(%rbp), %rax
               	shlq	$0x31, %rax
               	sarq	$0x31, %rax
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	movsbq	-0x78(%rbp), %rax
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
