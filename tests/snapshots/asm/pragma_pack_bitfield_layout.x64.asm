
pragma_pack_bitfield_layout.x64:	file format elf64-x86-64

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
               	subq	$0x98, %rsp
               	leaq	(%rsp), %rdi
               	movq	$0x0, (%rsp)
               	movl	(%rsp), %eax
               	andq	$-0x40000000, %rax      # imm = 0xC0000000
               	orq	$0x3fffffff, %rax       # imm = 0x3FFFFFFF
               	movl	%eax, (%rsp)
               	movq	(%rsp), %rax
               	movabsq	$-0xfffffffc0000001, %r11 # imm = 0xF00000003FFFFFFF
               	andq	%r11, %rax
               	movabsq	$0xaaaaaaa80000000, %r11 # imm = 0xAAAAAAA80000000
               	orq	%r11, %rax
               	movq	%rax, (%rsp)
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x8, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	(%rsp), %eax
               	shlq	$0x22, %rax
               	sarq	$0x22, %rax
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	movq	(%rsp), %rax
               	sarq	$0x1e, %rax
               	shlq	$0x22, %rax
               	sarq	$0x22, %rax
               	cmpl	$0xeaaaaaaa, %eax       # imm = 0xEAAAAAAA
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x98, %rsp
               	retq
               	leaq	0x8(%rsp), %rdi
               	movb	$0x0, 0x8(%rsp)
               	movb	$0x0, 0xc(%rsp)
               	movl	$0x1, 0x8(%rsp)
               	movzwq	0x9(%rsp), %rax
               	andq	$-0x8000, %rax          # imm = 0x8000
               	orq	$0x7ffe, %rax           # imm = 0x7FFE
               	movw	%ax, 0x9(%rsp)
               	movw	$0x1234, 0xb(%rsp)      # imm = 0x1234
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x5, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movsbq	0x8(%rsp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movzwq	0x9(%rsp), %rax
               	shlq	$0x31, %rax
               	sarq	$0x31, %rax
               	cmpl	$-0x2, %eax
               	jne	<addr>
               	movswq	0xb(%rsp), %rax
               	cmpl	$0x1234, %eax           # imm = 0x1234
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x98, %rsp
               	retq
               	leaq	0x20(%rsp), %rdi
               	movb	$0x0, 0x20(%rsp)
               	movw	$0x0, 0x28(%rsp)
               	movq	$0x1, 0x20(%rsp)
               	movq	0x21(%rsp), %rax
               	movabsq	$-0x1000000000000000, %r11 # imm = 0xF000000000000000
               	andq	%r11, %rax
               	movabsq	$0xffffffffffffff, %r11 # imm = 0xFFFFFFFFFFFFFF
               	orq	%r11, %rax
               	movq	%rax, 0x21(%rsp)
               	movb	$0x2, 0x29(%rsp)
               	leaq	<rip>, %rsi # <addr>
               	movl	$0xa, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x21(%rsp), %rax
               	shlq	$0x4, %rax
               	sarq	$0x4, %rax
               	movabsq	$0xffffffffffffff, %r11 # imm = 0xFFFFFFFFFFFFFF
               	cmpq	%r11, %rax
               	jne	<addr>
               	movsbq	0x29(%rsp), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x98, %rsp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movl	$0xf, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x98, %rsp
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
               	addq	$0x98, %rsp
               	retq
               	movq	$0x0, 0x30(%rsp)
               	movl	$0x0, 0x38(%rsp)
               	movw	$0x0, 0x3c(%rsp)
               	movb	$0x0, 0x3e(%rsp)
               	movl	0x30(%rsp), %eax
               	andq	$-0x400000, %rax        # imm = 0xFFC00000
               	orq	$0x79a, %rax            # imm = 0x79A
               	movl	%eax, 0x30(%rsp)
               	movl	0x32(%rsp), %eax
               	andq	$-0x1fffffc1, %rax      # imm = 0xE000003F
               	orq	$0x1ffe23c0, %rax       # imm = 0x1FFE23C0
               	movl	%eax, 0x32(%rsp)
               	movl	0x35(%rsp), %eax
               	andq	$-0x7fffffe1, %rax      # imm = 0x8000001F
               	orq	$0x27bc0, %rax          # imm = 0x27BC0
               	movl	%eax, 0x35(%rsp)
               	movzwq	0x38(%rsp), %rax
               	andq	$-0xf81, %rax           # imm = 0xF07F
               	orq	$0x200, %rax            # imm = 0x200
               	movw	%ax, 0x38(%rsp)
               	movl	0x39(%rsp), %eax
               	andq	$-0xfffff1, %rax        # imm = 0xFF00000F
               	orq	$0x16a0, %rax           # imm = 0x16A0
               	movl	%eax, 0x39(%rsp)
               	movl	0x3b(%rsp), %eax
               	andq	$-0xfffff01, %rax       # imm = 0xF00000FF
               	orq	$0x14100, %rax          # imm = 0x14100
               	movl	%eax, 0x3b(%rsp)
               	leaq	0x30(%rsp), %rdi
               	leaq	<rip>, %rsi # <addr>
               	movl	$0xf, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x98, %rsp
               	retq
               	leaq	0x40(%rsp), %rdi
               	movw	$0x0, 0x48(%rsp)
               	movq	$0x1, 0x40(%rsp)
               	movl	0x41(%rsp), %eax
               	andq	$-0x40000000, %rax      # imm = 0xC0000000
               	orq	$0x3fffffff, %rax       # imm = 0x3FFFFFFF
               	movl	%eax, 0x41(%rsp)
               	movq	0x42(%rsp), %rax
               	movabsq	$-0xfffffffc00001, %r11 # imm = 0xFFF00000003FFFFF
               	andq	%r11, %rax
               	movabsq	$0xaaaaaaa800000, %r11  # imm = 0xAAAAAAA800000
               	orq	%r11, %rax
               	movq	%rax, 0x42(%rsp)
               	leaq	<rip>, %rsi # <addr>
               	movl	$0xa, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movl	$0xa, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0x41(%rsp), %eax
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
               	addq	$0x98, %rsp
               	retq
               	leaq	0x10(%rsp), %rdi
               	movl	$0x1, 0x10(%rsp)
               	movzwq	0x11(%rsp), %rax
               	andq	$-0x8000, %rax          # imm = 0x8000
               	orq	$0x7ffe, %rax           # imm = 0x7FFE
               	movw	%ax, 0x11(%rsp)
               	movb	$0x3, 0x13(%rsp)
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x4, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzwq	0x11(%rsp), %rax
               	shlq	$0x31, %rax
               	sarq	$0x31, %rax
               	cmpl	$-0x2, %eax
               	jne	<addr>
               	movsbq	0x13(%rsp), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x98, %rsp
               	retq
               	leaq	0x50(%rsp), %rdi
               	movl	$0x0, 0x58(%rsp)
               	movq	$0x1, 0x50(%rsp)
               	movq	0x51(%rsp), %rax
               	movabsq	$-0x1000000000000000, %r11 # imm = 0xF000000000000000
               	andq	%r11, %rax
               	movabsq	$0xffffffffffffff, %r11 # imm = 0xFFFFFFFFFFFFFF
               	orq	%r11, %rax
               	movq	%rax, 0x51(%rsp)
               	movb	$0x2, 0x59(%rsp)
               	leaq	<rip>, %rsi # <addr>
               	movl	$0xc, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x51(%rsp), %rax
               	shlq	$0x4, %rax
               	sarq	$0x4, %rax
               	movabsq	$0xffffffffffffff, %r11 # imm = 0xFFFFFFFFFFFFFF
               	cmpq	%r11, %rax
               	jne	<addr>
               	movsbq	0x59(%rsp), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x98, %rsp
               	retq
               	movl	$0x0, 0x68(%rsp)
               	movl	$0x0, 0x78(%rsp)
               	movl	$0x0, 0x84(%rsp)
               	movl	$0x0, 0x88(%rsp)
               	movabsq	$0x3fffffff00000001, %rsi # imm = 0x3FFFFFFF00000001
               	movq	$0x1, 0x70(%rsp)
               	movq	$0x1, 0x60(%rsp)
               	movl	$0x3fffffff, %eax       # imm = 0x3FFFFFFF
               	movq	%rsi, 0x80(%rsp)
               	movl	0x71(%rsp), %ecx
               	andq	$-0x40000000, %rcx      # imm = 0xC0000000
               	orq	%rax, %rcx
               	movl	%ecx, 0x71(%rsp)
               	movl	0x61(%rsp), %ecx
               	andq	$-0x40000000, %rcx      # imm = 0xC0000000
               	orq	%rcx, %rax
               	movl	%eax, 0x61(%rsp)
               	leaq	0x60(%rsp), %rdi
               	movl	$0x2aaaaaaa, 0x88(%rsp) # imm = 0x2AAAAAAA
               	movq	0x74(%rsp), %rax
               	movabsq	$-0xfffffffc1, %rcx     # imm = 0xFFFFFFF00000003F
               	andq	%rax, %rcx
               	movabsq	$0xaaaaaaa80, %rax      # imm = 0xAAAAAAA80
               	orq	%rax, %rcx
               	movq	%rcx, 0x74(%rsp)
               	movq	0x64(%rsp), %rcx
               	movabsq	$-0xfffffffc1, %r11     # imm = 0xFFFFFFF00000003F
               	andq	%r11, %rcx
               	orq	%rcx, %rax
               	movq	%rax, 0x64(%rsp)
               	leaq	<rip>, %rsi # <addr>
               	movl	$0xc, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x70(%rsp), %rdi
               	leaq	<rip>, %rsi # <addr>
               	movl	$0xc, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	<rip>, %rsi # <addr>
               	movl	$0xc, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x98, %rsp
               	retq
               	movl	0x61(%rsp), %eax
               	shlq	$0x22, %rax
               	sarq	$0x22, %rax
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	movq	0x74(%rsp), %rax
               	sarq	$0x6, %rax
               	shlq	$0x22, %rax
               	sarq	$0x22, %rax
               	cmpl	$0xeaaaaaaa, %eax       # imm = 0xEAAAAAAA
               	jne	<addr>
               	movl	0x84(%rsp), %eax
               	shlq	$0x22, %rax
               	sarq	$0x22, %rax
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	movl	0x88(%rsp), %eax
               	shlq	$0x22, %rax
               	sarq	$0x22, %rax
               	cmpl	$0xeaaaaaaa, %eax       # imm = 0xEAAAAAAA
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x98, %rsp
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
               	addq	$0x98, %rsp
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
               	addq	$0x98, %rsp
               	retq
               	movzwq	<rip>, %rax # <addr>
               	shlq	$0x31, %rax
               	sarq	$0x31, %rax
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x98, %rsp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x2, %edx
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
               	addq	$0x98, %rsp
               	retq
               	leaq	0x18(%rsp), %rdi
               	movw	$0x0, 0x18(%rsp)
               	movw	$0x7ffd, 0x18(%rsp)     # imm = 0x7FFD
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x2, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzwq	0x18(%rsp), %rax
               	shlq	$0x31, %rax
               	sarq	$0x31, %rax
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	movsbq	0x18(%rsp), %rax
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0x98, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x98, %rsp
               	retq
